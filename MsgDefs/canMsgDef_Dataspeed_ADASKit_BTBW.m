function msgComp = canMsgDef_Dataspeed_ADASKit_BTBW()
%CANMSGDEF_DATASPEED_ADASKIT_BTBW	Dataspeed ADAS Kit CAN message definition.
%   
%	MSGCOMP = CANMSGDEF_DATASPEED_ADASKIT_BTBW() returns the Ford Fusion
%	Brake/Throttle-By-Wire CAN message definition for the Dataspeed ADAS
%	Kit.
% 
% Source: Ford Fusion BrakeThrottle-By-Wire Rev. A-12, Dataspeed Inc.
% 

msgComp = [...
	% Brake command
	CANMsgDef('0x060','Ford Fusion BrakeThrottle-By-Wire - Brake Command',[...
	CANMsgSignal('PCMD',	01, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('CMD_TYPE',21, 04, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('EN',		25, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CLEAR',	26, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('IGNORE',	27, 01, 'U', 'LE', 0, 2, ''),...
	CANMsgSignal('COUNT',	57, 08, 'U', 'LE', 0, 2, ''),...
	]);
	% Brake report
	CANMsgDef('0x061','Ford Fusion BrakeThrottle-By-Wire - Brake Report',[...
	CANMsgSignal('PI',		01, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('PC',		17, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('PO',		33, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('BTTYPE',	49, 01, 'U', 'LE', 0, 1, 'Nm'),...
	CANMsgSignal('BC',		50, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('BI',		51, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('WDCBRK',	52, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('WDCSRC',	53, 04, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('EN',		57, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('OVERRIDE',58, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DRIVER',	59, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTWDC',	60, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLT1',	61, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLT2',	62, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTPWR',	63, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('TMOUT',	64, 01, 'U', 'LE', 0, 1, ''),...
	]);...
	% Throttle command
	CANMsgDef('0x062','Ford Fusion BrakeThrottle-By-Wire - Throttle Command',[...
	CANMsgSignal('PCMD',	01, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('CMD_TYPE',21, 04, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('EN',		25, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CLEAR',	26, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('IGNORE',	27, 01, 'U', 'LE', 0, 2, ''),...
	CANMsgSignal('COUNT',	57, 08, 'U', 'LE', 0, 2, ''),...
	]);
	% Throttle report
	CANMsgDef('0x063','Ford Fusion BrakeThrottle-By-Wire - Throttle Report',[...
	CANMsgSignal('PI',		01, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('PC',		17, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('PO',		33, 16, 'U', 'LE', 0, 100/65535, '%'),...
	CANMsgSignal('WDCSRC',	53, 04, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('EN',		57, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('OVERRIDE',58, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DRIVER',	59, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTWDC',	60, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLT1',	61, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLT2',	62, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTPWR',	63, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('TMOUT',	64, 01, 'U', 'LE', 0, 1, ''),...
	]);...
	% Version
	CANMsgDef('0x07F','Ford Fusion BrakeThrottle-By-Wire - Version',[...
	CANMsgSignal('MODULE',	01, 08, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('PLATFORM',09, 08, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('MAJOR',	17, 16, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('MINOR',	33, 16, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('BUILD',	49, 16, 'U', 'LE', 0, 1, ''),...
	]);
	];


end%fcn
