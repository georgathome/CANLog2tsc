classdef CANMsgDef
%CANMSGDEF	Definition of CAN message byte layout.
%	OBJ = CANMSGDEF() creates the instance OBJ of class CANMSGDEF using
%	default values.
%	
%	OBJ = CANMSGDEF(ID,NAME,SIGNALS) creates the instance OBJ of class
%	CANMSGDEF using provided inputs.
% 	
%	CANMSGDEF properties:
%	 MSGID		- Message ID (hex).
%	 MSGNAME	- Message name.
%	 SIGNALS	- Array of CANMSGSIGNAL objects defining CAN message byte 
%				  layout.
% 
%	CANMSGDEF methods:
%	 UNIQUE - Check uniqueness of CANMSGDEF array elements based on ID.
%	
%	See also CANMSGSIGNAL.
% 
% 
% Subject: Import CAN logs.
% $Author: georgne $
% $LastChangedDate: 2020-08-04 21:48:38 +0200 (Di, 04 Aug 2020) $
% $Revision: 410 $


	properties (SetAccess = private)
		MsgID(1,:) string	= string()
		MsgName(1,:) string	= string()
		Signals(1,:) CANMsgSignal = CANMsgSignal();
	end%properties
	
	
	methods
		
		function obj = CANMsgDef(ID, Name, signals)
		%CANMSGDEF	Construct an instance of this class.
			
			narginchk(0, 3)
			if nargin < 1
				% return with default values
			else
				obj.MsgID	= ID;
				obj.MsgName = Name;
				obj.Signals = signals;
			end%if
			
		end%CONSTRUCTOR
		
		function S = convert2tsc(OBJ, time, ID_hex, data_hex)
		%MSGS2TSC	Convert CAN messages to TSCOLLECTION.
		%   S = MSGS2TSC(OBJ, MSGS, TIMESCALE)
					
			%%% Init data arrays before looping over all CAN messages
			% This is the number of CAN messages we want to convert to
			% TSCOLLECTION (one TSCOLLECTION per CAN message definition)
			[OBJ, nbrMsgDefs] = unique(OBJ);
			
			% This is the number of signals per CAN message
			nbrSignalsPerMsg = cellfun(@numel, {OBJ.Signals});
			
			% Get the number MSGCNT of lines and the line indexes MSGIND
			% per message ID requested via OBJ.MSGID
			msgCnt =  NaN(nbrMsgDefs, 1);
			msgInd = cell(nbrMsgDefs, 1);
			ID_dec = hex2dec(ID_hex);
			for i = 1:nbrMsgDefs
				% Extract just the message ID from the structs field name,
				% remove leading 0/x
				msgID_i = OBJ(i).MsgID;
				while (numel(msgID_i) > 0) && startsWith(msgID_i, {'0','x'})
					msgID_i = extractAfter(msgID_i, 1);
				end%if
				
				% Get the number and line indices of messages with this ID
				msgInd{i} = find(ID_dec == hex2dec(msgID_i));
				msgCnt(i) = numel( msgInd{i} );
				
				% Initialize time/data array for every message ID in MSGDEFS
				CAN(i).Name = join(['msg', OBJ(i).MsgID], '_');
				CAN(i).Time = NaN(1,					msgCnt(i)); %#ok<AGROW>
				CAN(i).Data = NaN(nbrSignalsPerMsg(i),	msgCnt(i)); %#ok<AGROW>
			end%for
			
			% Init variables for printing status to screen
			nbrOfLoops = sum(msgCnt);
			done_percent_old = 0; 
			loopCnt = 0;
			fprintf('  > Converting %d messages...\n', sum(msgCnt));
			if sum(msgCnt) > 0
				fprintf('    %d%% ', done_percent_old);
			else
				fprintf('    ---');
			end%if
			
			
			%%% Loop through all specified CAN message definitions
			for i = 1:nbrMsgDefs
				
				% Now loop over the indexes in MSGS, with CAN message ID
				% given by OBJ(i)
				msgInd_i = msgInd{i};
				
				% Get the time values (time is in seconds!)
				CAN(i).Time = time(msgInd_i);
				
				% Get the data byte values for all time samples
				hexBytes_i = data_hex(msgInd_i, :);
				
				for j = 1:numel(msgInd_i)
					
					% Print status info to screen
					loopCnt = loopCnt + 1;
					done_percent = loopCnt/nbrOfLoops*100;
					if (done_percent-done_percent_old) > 10
						% print status info to screen in 10% steps
						fprintf('%d%% ', round(done_percent));
						done_percent_old = done_percent;
					end%if
					
					% Convert to decimal numbers based on CAN message
					% definition
					Data = OBJ(i).Signals.hexBytes2dec(hexBytes_i(j, :));
					
					% Assign data of single time step CAN message to
					% time-indexed data array
					CAN(i).Data(:,j) = Data;
					
				end%for
			end%for
			
			fprintf('\n');
			
			
			%%% Convert each type of CAN message type (ID) to time series
			%%% collection
			fn = [CAN.Name];
			for i = 1:numel(fn)
				time = CAN(i).Time;
				
				if any(isnan(time))
					K = find(isnan(time), 1, 'first') - 1;
				else
					K = numel(time);
				end%if
				
				Data = CAN(i).Data;
				name_tsc = OBJ(i).MsgName;
				if isempty(name_tsc)
					name_tsc = fn(i);
				end
				tsc = tscollection(time(1:K), 'Name',name_tsc);
				for k = 1:size(Data, 1)
					name = OBJ(i).Signals(k).Name;
					unit = OBJ(i).Signals(k).Unit;
					data = Data(k,1:K);
					if isvector(data)
						% This should make sure that the DATA field of TS
						% is not a three dimensional array like 1-by-1-by-N
						ts = timeseries(data', time(1:K), 'Name',name);
					else
						ts = timeseries(data, time(1:K), 'Name',name);
					end%if
					ts.DataInfo.Unit = unit;
					ts.DataInfo.Interpolation = 'zoh';
					tsc = addts(tsc, ts);
				end%for
				S.(fn(i)) = tsc;
			end%for
			
			fprintf('  > DONE.\n\n');
			
		end%fcn
		
		function [obj, NU, N] = unique(OBJ)
		% UNIQUE	Get message definitions which have unique IDs.
		%	OBJU = UNIQUE(OBJ) returns the array OBJU of unique CANMSGDEF
		%	elements based on property ID.
		% 
		%	[_,NU,N] = UNIQUE(OBJ) returns the numbers NU and N of elements
		%	in the unique and original array, respectively.
		%
			
			% This is the total number of CAN message definitions
			N = numel(OBJ);
			
			% Get all MsgIDs and convert their hex representation to
			% decimal. This way the actual value of MsgID is used for
			% finding unique MsgIDs and not its character representation
			% (like '0x123' or just '123').
			msgIDs = [OBJ.MsgID];
			msgID_dec = hex2dec(strrep(msgIDs, 'x', '0'));
			
			% Find unique CAN message definitions based on decimal
			% representation of MsgID
			%  [ID_unique, ind_unique] = unique({OBJ.MsgID}, 'stable');
			%  ID_unique = {OBJ(ind_unique).MsgID}
			[~, ind_unique] = unique(msgID_dec, 'stable');
			
			% Unique message definitions
			obj = OBJ(ind_unique);
			NU = numel(ind_unique);
			
			% Issue a warning if there were redundant message definitions
			if NU ~= N
				warning('CANMSGDEF:UNIQUE:redundantMsgID', ...
					'Based on MsgID, %d redundant message definition(s) removed!', ...
					N - NU);
			end%if
			
		end%if
		
	end%methods
	
	
	
	%%% SET-Methods
	methods
		function obj = set.Signals(obj, prop)
% 			if ~isa(prop, 'CANMsgSignal')
% 				error(['Error setting property "Signals".', ...
% 					'Data type must be CANMsgSignal!']);
% 			end%if
			obj.Signals = prop;
		end%fcn
	end%methods
	
end%class
