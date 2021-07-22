classdef CANLogReaderASC < CANLogReader
% CANLOGREADERASC	Import CAN log files in Xylon datalogger format.
% 
%	CANLogReaderASC Methods:
%	CANLogReaderASC - Constructor.
% 
%	See also CANLOGREADER.


	properties (SetAccess = private, Hidden)
		DataRowInitChar = ' ';
		Format = '%f %u8 %s %C %C %u8 %[^\n]';
		Timescale = 1.0;
	end
	
	
	methods
		
		function obj = CANLogReaderASC(filename)
		% CANLOGREADERASC	Class Constructor.
		%   OBJ = CANLOGREADERASC(FILENAME) create an instance of class
		%	CANLOGREADERASC with log file FILENAME.
		
			% Create object by calling superclass constructor
			obj = obj@CANLogReader(filename);
			
			% Extract data from header lines.
			obj = obj.parseHeaderLines();
			if ~strcmp(obj.FileVersion, '8.0.0')
				warnmsg = [...
					'The VERSION keyword has a value of %s. ',...
					'Only log files with a value of 7.0.0 are tested. ',...
					'Use results with care!'];
				warning(warnmsg, obj.FileVersion);
			end%if
			
		end%CONSTRUCTOR
		
		function tsc = convert2tsc(obj, msgDef, channel, readLines)
		%	S = CONVERT2TSC(OBJ,MSGDEF,CHANNEL) converts the log files CAN
		%	messages of channel CHANNEL to a struct S of TSCOLLECTION
		%	objects.
		% 
		%	See also CANLOGREADER/CONVERT2TSC, CANLOGREADERXYLON/READ. 
		
			narginchk(3, 4);
			
			CANLogReader.verifyMsgDefType(msgDef);
			
			if nargin < 4
				S = read(obj);
			else
				S = read(obj, readLines);
			end%if
			
			% Convert messages of specific channel
			matchesChannel = (S.Channel == channel);
			tsc = convert2tsc(msgDef, ...
				S.Time(matchesChannel, :)*obj.Timescale, ...
				S.ID(matchesChannel, :), ...
				S.DataBytes(matchesChannel, :));
			
		end%fcn
		
		function S = read(obj, readLines)
		%
			
			% Import file content
			fid = fopen(getFullFilePath(obj), 'r');
			C = textscan(fid, '%s', ...
				'Delimiter', '\n', ...
				'HeaderLines', numel(obj.HeaderLines));
			
			if nargin < 2
				% Keep all lines.
				C = C{1};
			else
				% Keep only specified lines, if requested.
				C = C{1}(readLines);
			end%if
			
			% Parse lines
			S = obj.parseMsgLines(C);
			
		end%fcn
		
		function t = table(obj)
		%
		
% 			t = readtable(obj.Filename, ...
% 				'Delimiter',' ', ...
% 				'FileType', 'text', ...
% 				'Format', '%f %u8 %s %C %C %u8 %[^\n]', ...
% 				'HeaderLines', numel(obj.HeaderLines), ...
% 				'MultipleDelimsAsOne', true, ...
% 				'ReadVariableNames', false, ...
% 				'TextType', 'string');
			
			S = read(obj);
			t = struct2table(S);
			
		end%fcn
		
		function tt = timetable(obj)
		%
		
			t = table(obj);
			t.Time = seconds(t.Time)*obj.Timescale;
			tt = table2timetable(t, 'RowTimes','Time');
		end%fcn
		
	end%methods
	
	
	methods (Access = private)
		
		function obj = parseHeaderLines(obj)
			lines = obj.HeaderLines(~cellfun(@isempty, obj.HeaderLines));
			
			% Date
			temp = regexp(lines{1,:}, ...
				'date \w\w\w (?<Month>\w+) (?<Day>\d+) (?<Time>[\d:]+) (?<Year>\d+)', ...
				'names');
			obj.DateTime = datetime([strjoin({temp.Day,temp.Month,temp.Year}, '.'), ...
				' ', temp.Time]);
			
			% Fileverison
			temp = regexp([lines{:}], 'version (?<Version>(\d+.)+\d+)', 'names');
			obj.FileVersion = temp.Version;
			
		end%fcn
		
		function S = parseMsgLines(obj, cellOfLines)

			C = regexp(cellOfLines, [...
				'\s*(?<Time>\d+\.\d+)',... % Time in ms
				'\s+(?<Channel>\d+)',... % CAN channel number
				'\s+(?<ID>[0-9a-fA-F]+)',... % ID (hex)
				'\s+(?<Rx_Tx>[RxTx]+)',... % Receive/transmit
				'\s+d (?<DataLength>\d)',... % Data Length
				'\s+(?<DataBytes>([\w{2}\s*]+))\r',... % Data Bytes (hex)
				], 'names');

			% Converting to struct array, eliminates empty cells
			C = cat(1, C{:});

			S.Time		= str2num(char(C.Time));
			S.Channel	= uint8(str2num(char(C.Channel)));
			S.ID		= char(C.ID);
			S.Rx_Tx		= categorical({C.Rx_Tx}');
			S.DataLength = uint8(str2num(char(C.DataLength)));
			S.DataBytes = char(C.DataBytes);

		end%fcn
		
	end%methds
	
end%class
