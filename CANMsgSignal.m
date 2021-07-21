classdef CANMsgSignal
%CANMSGSIGNAL	Define signal of CAN Message.
% 
%	OBJ = CANMSGSIGNAL() creates the instance OBJ of the CANMSGSIGNAL class
%	using default values.
%	
%	OBJ =
%	CANMSGSIGNAL(NAME,STARTBIT,SIGNALLENGTH,DATATYPE,BYTELAYOUT,OFFSET,FACTOR)
%	creates the instance OBJ of the CANMSGSIGNAL class using provided
%	inputs.
%	
%	OBJ = CANMSGSIGNAL(___,UNIT) sets the signals unit to UNIT.
%	
%	CANMSGSIGNAL properties:
%	 NAME			- Signal name (string).
%	 STARTBIT		- Start bit in the CAN message (1-based indexing).
%	 SIGNALLENGTH	- Number of bits of the signal.
%	 DATATYPE		- Data type of the signal ("S", "U", "F").
%	 BYTELAYOUT		- Byte layout ("LE", "BE", "MB").
%	 OFFSET			- Offset.
%	 FACTOR			- Factor.
%	 UNIT			- Physical unit of the signal (optional, string).
%	
%	CANMSGSIGNAL methods:
%	 CANMSGSIGNAL	- Class constructor.
%	 HEXBYTES2DEC	- Convert CAN message to decimal values.
%	
%	See also CANMSGDEF.
% 
% 
% Subject: Import CAN logs.
% $Author: georgne $
% $LastChangedDate: 2021-03-15 13:26:27 +0100 (Mo, 15 Mrz 2021) $
% $Revision: 437 $


	properties (SetAccess = private)
		Name(1,:) string		= string();
		StartBit(1,1) int8		= 1;
		SignalLength(1,1) int8	= 1;
		DataType(1,1) string {mustBeMember(DataType, ["S","U","F"])} = "U";
		ByteLayout(1,1) string {mustBeMember(ByteLayout,["LE","BE","MB"])} = "LE";
		Offset(1,1) double		= 0;
		Factor(1,1) double		= 1;
		Unit(1,:) string		= string();
	end%properties
	
	
	methods
		
		function obj = CANMsgSignal(NAME, BIT0, BITN, TYPE, BLAYOUT, ...
				OFFSET, FACTOR, UNIT)
		% CANMSGSIGNAL	Construct an instance of class CANMsgSignal.
		
			if nargin < 1
				% return with default values
				return;
			else
				obj.Name		= NAME;
				obj.StartBit	= BIT0;
				obj.SignalLength= BITN;
				obj.DataType	= TYPE;
				obj.ByteLayout	= BLAYOUT;
				obj.Offset		= OFFSET;
				obj.Factor		= FACTOR;
			end%if
			
			if nargin > 7
				% Explicit cast to string, since R2018b fails to cast empty
				% chars ('') automatically.
				obj.Unit = string(UNIT);
			end%if
			
		end%CONSTRUCOR
		
		function data = hexBytes2dec(obj, hexBytes)
		% HEXBYTES2DEC	Convert CAN message signals to decimal values.
		% 
			
			% Number of signals to convert from hex to dec
			nbrSig = numel(obj);
			
			% Convert char array HEXBYTES of hex values to binary
			binBytes = hex2bin(hexBytes);
			
			% Repeatedly indexing into OBJ is quite slow! Therefore, get
			% required data before for-loop.
			startIndexes = cat(1, obj.StartBit);
			endIndexes = cat(1, obj.SignalLength) + startIndexes - 1;
			factors = cat(1, obj.Factor);
			offsets = cat(1, obj.Offset);
			byteLayouts = cat(1, obj.ByteLayout);
			dataTypes = cat(1, obj.DataType);
			
			% Init for-loop arrays
			bits = cell(nbrSig, 1);
			offset_sign = zeros(nbrSig, 1);
			for SIGNAL = 1:nbrSig
				
				ind0 = startIndexes(SIGNAL);
				ind1 = endIndexes(SIGNAL);
				
				switch byteLayouts(SIGNAL)
					case {'LE'}
						binBytesVec = reshape(flip(binBytes, 2)', 1, numel(binBytes));
						bits{SIGNAL} = binBytesVec(ind1:-1:ind0);
					
					case {'BE'} % Untested!!
						error('Big Endian byte layout NOT IMPLEMENTED!')
						
					case {'MB'}
						binBytesVec = reshape(flip(flip(binBytes, 1), 2)', 1, numel(binBytes));
						bits{SIGNAL} = binBytesVec(ind1:-1:ind0);
					
				end%switch
				
				switch dataTypes(SIGNAL)
					case {'S'} % first bit is a negative value!
						
						if strcmp(bits{SIGNAL}(1),'0')
							offset_sign(SIGNAL) = 0;
						else
							offset_sign(SIGNAL) = -2^(numel(bits{SIGNAL})-1);
						end%if
						bits{SIGNAL} = bits{SIGNAL}(2:end);
						
% 					case 'U' % Initialized with zero -> nothing to do!
% 						offset_sign(SIGNAL) = 0;

					case {'F'}
						error('Data type setting F not implemented!');
						
				end%switch
				
			end%for
			
			data = (bin2dec(bits)+offset_sign).*factors + offsets;
			
		end%fcn
		
	end%methods
	
end%class
