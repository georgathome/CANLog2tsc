classdef (InferiorClasses = {?CANMsgDef}) CANLogReader
%CANLOGREADER	Import CAN log files from different sources.
%	OBJ = CANLOGREADER(FILENAME) creates an instance OBJ of the subclass
%	which calles this superclass constructor method. The file to be
%	imported is specified via its filename FILENAME.
% 	
%	CANLogReader Properties:
%	  Filename - The name of the log file.
%	  Filepath - The path of the log file.
%	  MachineFmt - The machine format used to process the log file.
%	  Encoding - The file encoding used to process the log file.
%	  HeaderLines - The header lines of the log file.
%	  DateTime	- Logfile date/time.
%	  FileVersion - Logfile version.
% 
%	CANLogReader Methods:
%	  CONVERT2TSC - Convert log file to timeseries collection.
%	  table - Import log file as table.
%	  timetable - Import log file as timetable.
%	  read - Import log file as structure.
% 	
%	NOTE: This class is abstract and can not be instantiated!
% 	
%	Compatibility: R2016b
% 	
%	See also: CANLOGREADERPEAK, CANLOGREADERASC.
	
	
	properties (SetAccess = private)
		% FILENAME - The filename of the log file.
		%	1-by-1 string.
		Filename(1,1) string
		
		% FILEPATH - The path of the log file.
		%	1-by-1 string.
		Filepath(1,1) string
		
		% MACHINEFMT - The machine format used to process the log file.
		%	1-by-1 string.
		MachineFmt(1,1) string
		
		% ENCODING - The file encoding used to process the log file.
		%	1-by-1 string.
		Encoding(1,1) string
		
		% HEADERLINES - The header lines of the log file.
		%	N-by-1 string array where N < 101.
		HeaderLines(:,1) string = strings(100, 1);
	end%properties
	
	properties (SetAccess = protected)
		% DATETIME - Date and time of the log file.
		%	1-by-1 datetime.
		DateTime(1,1) datetime = NaT;
		
		% FILEVERSION - Version of log file format.
		%	N-by-1 string.
		FileVersion(:,1) string;
	end%properties
	
	properties (SetAccess = private, Abstract)
		
		% DATAROWINITCHAR - Initial character of a line of logged data.
		%	1-by-1 string.
		DataRowInitChar(1,1) string;
		
		% FORMAT - Conversion specifier as used by TEXTSCAN or READTABLE.
		%	1-by-N character array.
		Format(1,:) char;
		
		% TIMESCALE - Conversion factor from logged time stamps to seconds.
		%	For given logged timestamps T, the product T*TIMESCALE is in
		%	seconds.
		%	1-by-1 double.
		Timescale(1,1) double;
	end%properties
	
	
		
	methods
		
		function obj = CANLogReader(filename)
			%CANLOGREADER	Create an instance of class CANLOGREADER.
			%   OBJ = CANLOGREADER(FILENAME)
			
			% Open the file and store the file identifier
			[fid, err] = fopen(filename, 'r');
			if isempty(err) 
				[filename,~,machinefmt,encodingOut] = fopen(fid);
				[filePath,fileName,fileExt] = fileparts(filename);
				obj.Filepath = filePath;
				obj.Filename = [fileName, fileExt];
				obj.MachineFmt = machinefmt;
				obj.Encoding = encodingOut;
			else
				error([err, ': %s'], obj.Filename);
			end%if
			
			% Extract header-info by reading file line by line until we
			% find a line that does start with DATAROWINITCHAR
			i = 1;
			header = strings(size(obj.HeaderLines)); % init based on default value
			while i < size(header, 1)
				line = fgetl(fid);
				if strcmp(line(1), obj.DataRowInitChar)
					fclose(fid);
					break;
				end%if
				header(i,1) = line; 
				
				% When while statement is finished, i is the line number
				% refering to message number 1 of the trace file TRACEFILE
				i = i+1; 
			end%if
			obj.HeaderLines = header(1:i-1);
			
		end%CONSTRUCTOR
		
		function s = getFullFilePath(obj)
			s = strjoin([obj.Filepath, obj.Filename], filesep);
		end%fcn
		
	end%methods
	
	
	methods (Abstract)
		
		% READ	Read log file.
		%	S = READ(OBJ) import the log file as a struct.
		%
		%	S = READ(OBJ,READLINES) reads only the lines indicated by
		%	REDALINES. READLINES is a vector of positional indexes or a
		%	logical index of appropriate size.
		%	
		%	See also CANLOGREADER/TABLE, CANLOGREADER/TIMETABLE.
		S = read(obj, readLines)
		
		% TABLE		Read log file as table.
		%	T = TABLE(OBJ) import the log file as a table object.
		%
		%	This method is implemented for backwards compatibility.
		%	
		%	See also TABLE, CANLOGREADER/TIMETABLE.
		t = table(obj)
		
		% TIMETABLE		Read log file as timetable.
		%	TT = TIMETABLE(OBJ) import the log file as a timetable object.
		%
		%	TT = TIMETABLE(OBJ,TSCALE) import the log file and scale the
		%	time stamps by TSCALE.
		%
		%	See also TIMETABLE, CANLOGREADER/TABLE.
		tt = timetable(obj)
		
		% CONVERT2TSC	Convert log file to TSCOLLECTION.
		%	S = CONVERT2TSC(OBJ,MSGDEF) converts the log file to a struct S
		%	of TSCOLLECTION objects. Struct S has one field for every
		%	element of MSGDEF with field names "msg_(MSGDEF.MSGID)".
		% 
		%	See also TSCOLLECTION, CANLOGREADER/READ, CANMSGDEF.
		S = convert2tsc(obj, msgDef, readLines)
		
	end%methods
	
	
	methods (Static, Access=protected)
		
		function verifyMsgDefType(msgDef)
			if ~isa(msgDef, 'CANMsgDef')
				error('Message definition must be of class CANMSGDEF.');
			end%if
		end%fcn
		
	end%fcn
	
end%class
