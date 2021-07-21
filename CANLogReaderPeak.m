classdef CANLogReaderPeak < CANLogReader
%CANLOGREADERPEAK	Import CAN log files in PEAK Systems format.
%	OBJ = CANLOGREADERPEAK(FILENAME) create an instance of class
%	CANLOGREADERPEAK for the log file FILENAME.
% 
%	See also CANLOGREADER.

	
	properties (SetAccess = private, Hidden)
		DataRowInitChar = ' ';
		Format = '%u64) %f %C %s %u8 %[^\n]';
		Timescale = 1e-3;
		VariableNames = {...
			'MsgNbr', ...
			'TimeOffset', ...
			'Rx_Tx', ...
			'ID_hex', ...
			'DataLength', ...
			'DataBytes_hex'};
	end%properties
	
	
	
	methods
		
		function obj = CANLogReaderPeak(filename)
			
			% Create object by calling superclass constructor
			obj = obj@CANLogReader(filename);
			
			% Extract data from header lines.
			obj = parseHeaderLines(obj);
			if ~strcmp(obj.FileVersion, '1.1')
				warnmsg = [...
					'The FILEVERSION keyword has a value of %s. ',...
					'Only trace files with a value of 1.1 are tested. ',...
					'Use results with care!'];
				warning(warnmsg, obj.HeaderInfo.FileVersion);
			end%if
			
		end%CONSTRUCTOR
		
		function tsc = convert2tsc(obj, msgDef, readLines)
		%
		
			CANLogReader.verifyMsgDefType(msgDef);
			
			if nargin < 3
				S = read(obj);
			else
				S = read(obj, readLines);
			end%if
			
			% Convert messages
			tsc = convert2tsc(msgDef, ...
				S.TimeOffset*obj.Timescale, ...
				S.ID_hex, ...
				S.DataBytes_hex);
			
		end%fcn
		
		function S = read(obj, readLines)
		% 
			
			% Import file content // textscan() requires R2006a
			fid = fopen(getFullFilePath(obj), 'rt');
			C = textscan(fid, obj.Format, ...
				'HeaderLines',numel(obj.HeaderLines));
% 				'TextType','string'); This option requires R2016b!
			fclose(fid);
			
			n = cellfun(@numel, C);
			if any(n(1) ~= n)
				error('READ() failed reading log file!')
			end%if
			
			% Find cells of cell arrays and convert to char arrays (require
			% significantly less memory)
			isCell = cellfun(@iscell, C);
			for i = find(isCell)
				C{i} = char(C{i});
			end%for
			
			if nargin < 2
				% Return all lines
				S = cell2struct(C, obj.VariableNames, 2);
			else
				% Return with specified lines
				S = cell2struct(...
					cellfun(@(x) x(readLines, :), C, 'UniformOutput', false), ...
					obj.VariableNames, 2);
			end%if
			
		end%fcn
		
		function t = table(obj)
		%
			
			% READTABLE()/TABLE() requires R2013b.
			t = readtable(obj.Filename, ...
				'Delimiter',' ', ...
				'FileType', 'text', ...
				'Format',obj.Format, ...
				'HeaderLines', numel(obj.HeaderLines), ...
				'MultipleDelimsAsOne', true, ...
				'ReadVariableNames', false, ...
				'TextType','string');
			
			t.Properties.VariableNames = obj.VariableNames;
			
		end%fcn
		
		function tt = timetable(obj)
		%
			
			t = table(obj);
			% TABLE2TIMETABLE() requires R2016b
			t.TimeOffset = seconds(t.TimeOffset)*obj.Timescale;
			tt = table2timetable(t, 'RowTimes','TimeOffset');
			
		end%fcn
		
	end%methods
	
	
	methods (Access = private)
		
		function obj = parseHeaderLines(obj)
			
			lines = [obj.HeaderLines{:}];
			
			% Fileverison
			temp = regexp(lines, ...
				'FILEVERSION=(?<FileVersion>\d+\.\d+)',	'names');
			obj.FileVersion = temp.FileVersion;
			
			% Start time numeric
			temp = regexp(lines, ...
				'STARTTIME=(?<StartTimeNum>\d+.\d*)', 'names');
% 			obj.StartTimeNum = temp.StartTimeNum;
			
			% Start time string
			temp = regexp(lines, ...
				'Start time: (?<StartTimeStr>[\d\. \:]*)', 'names');
			obj.DateTime = datetime(temp.StartTimeStr(1:23));
			
		end%fcn
		
	end%methods
	
end%class
