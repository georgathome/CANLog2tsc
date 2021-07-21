function msgComp = canMsgDef_Dataspeed_ADASKit_SBW()
%CANMSGDEF_DATASPEED_ADASKIT_SBW	Dataspeed ADAS Kit CAN message definition.
%   
%	MSGCOMP = CANMSGDEF_DATASPEED_ADASKIT_SBW() returns the Ford Fusion
%	Steer-By-Wire CAN message definition for the Dataspeed ADAS Kit.
% 
% Source: Ford Fusion Steer-By-Wire Rev. A-17, Dataspeed Inc.
% 

msgComp = [...
	% Steering command
	CANMsgDef('0x064','Ford Fusion Steer-By-Wire - Steering Command',[...
	CANMsgSignal('SCMD',	01, 16, 'S', 'LE', 0, .1, '�'),...
	CANMsgSignal('EN',		17, 01, 'U', 'LE', 0, 1, '-'),...
	CANMsgSignal('CLEAR',	18, 01, 'U', 'LE', 0, 1, '-'),...
	CANMsgSignal('IGNORE',	19, 02, 'U', 'LE', 0, 1, '-'),...
	CANMsgSignal('SVEL',	25, 08, 'U', 'LE', 0, 2, '�/sec'),...
	]);
	% Steering report
	CANMsgDef('0x065','Ford Fusion Steer-By-Wire - Steering Report',[...
	CANMsgSignal('ANGLE',	01, 16, 'S', 'LE', 0, .1, '�'),...
	CANMsgSignal('CMD',		17, 16, 'S', 'LE', 0, .1, '�'),...
	CANMsgSignal('SPEED',	33, 16, 'U', 'LE', 0, .01, 'km/h'),...
	CANMsgSignal('TORQUE',	49, 08, 'S', 'LE', 0, 0.0625, 'Nm'),...
	CANMsgSignal('EN',		57, 01, 'U', 'LE', 0, 1, '-'),...
	]);...
	% Shifting report
	CANMsgDef('0x067','Ford Fusion Steer-By-Wire - Shifting Report',[...
	CANMsgSignal('STATE',	01, 03, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DRIVER',	04,	01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CMD',		05, 03, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTBUS',	08, 01, 'U', 'LE', 0, 1, ''),...
% 	CANMsgSignal('REJECT',	09, 03, 'LE', 0, 1, ''),...
% 	CANMsgSignal('READY',	16, 01, 'LE', 0, 1, ''),...
	]);...
	% Turn signal command
	CANMsgDef('0x068','Ford Fusion Steer-By-Wire - Turn Signal Command',[...
	CANMsgSignal('TRNCMD',	01, 02, 'U', 'LE', 0, 1, ''),...
	]);...
	% Miscellaneous report
	CANMsgDef('0x069','Ford Fusion Steer-By-Wire - Miscellaneous Report',[...
	CANMsgSignal('TRNSTAT',	01, 02, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('HIBEAM',	03, 02, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('WIPER',	05, 04, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('AMBIENT',	09, 03, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ON',		12, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('OFF',		13, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('RES',		14, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CNCL',	15, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('RINC',	16, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ONOFF',	17, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('RESCNCL',	18, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('SINC',	19, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('SDEC',	20, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('GINC',	21, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LKAEN',	22, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('FLTBUS',	23, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DOORD',	24, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DOORP',	25, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DOORL',	26, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('DOORR',	27, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('HOOD',	28, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('TRUNK',	29, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('PDECT',	30, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('PABAG',	31, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('BELTD',	32, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('BELTP',	33, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LDOK',	34, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LDUP',	35, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LDDWN',	36, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LDLFT',	37, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('LDRHT',	38, 01, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('RDEC',	39, 01, 'U', 'LE', 0, 1, ''),...
% 	CANMsgSignal('OTEMP',	56, 08, 'S', 'LE', 0, 1, '�C'),... % factor/offset??
	]);...
	% Wheel speed
	CANMsgDef('0x06A','Ford Fusion Steer-By-Wire Wheel Speed',[...
	CANMsgSignal('FL',		01, 16, 'S', 'LE', 0, 0.01, 'rad/s'),...
	CANMsgSignal('FR',		17, 16, 'S', 'LE', 0, 0.01, 'rad/s'),...
	CANMsgSignal('RL',		33, 16, 'S', 'LE', 0, 0.01, 'rad/s'),...
	CANMsgSignal('RR',		49, 16, 'S', 'LE', 0, 0.01, 'rad/s'),...
	]);...
	% Acceleration
	CANMsgDef('0x06B','Ford Fusion Steer-By-Wire - Acceleration',[...
	CANMsgSignal('LAT',		01, 16, 'S', 'LE', 0, 0.01, 'm/s�'),...
	CANMsgSignal('LONG',	17, 16, 'S', 'LE', 0, 0.01, 'm/s�'),...
	CANMsgSignal('VERT',	33, 16, 'S', 'LE', 0, 0.01, 'm/s�'),...
	]);...
	% Angular rates
	CANMsgDef('0x06C','Ford Fusion Steer-By-Wire - AngularRates',[...
	CANMsgSignal('ROLL',	01, 16, 'S', 'LE', 0, 0.0002, 'rad/s'),...
	CANMsgSignal('YAW',		17, 16, 'S', 'LE', 0, 0.0002, 'rad/s'),...
	]);...
	% GPS 1
	CANMsgDef('0x06D','Ford Fusion Steer-By-Wire - GPS 1',[...
	CANMsgSignal('LATITUDE',	01, 31, 'S', 'LE', 0, 3.33333e-07, '�'),...
	CANMsgSignal('LONGITUDE',	33, 31, 'S', 'LE', 0, 3.33333e-07, '�'),...
	CANMsgSignal('VALID',		64, 01, 'U', 'LE', 0, 1, ''),...
	]);...
	% GPS 2
	CANMsgDef('0x06E','Ford Fusion Steer-By-Wire - GPS 2',[...
	CANMsgSignal('YEAR',	01, 7, 'U', 'LE', 0, 1, 'yy'),...
	CANMsgSignal('MONTH',	09, 4, 'U', 'LE', 0, 1, 'mm'),...
	CANMsgSignal('DAY',		17, 5, 'U', 'LE', 0, 1, 'dd'),...
	CANMsgSignal('HOURS',	25, 5, 'U', 'LE', 0, 1, 'HH'),...
	CANMsgSignal('MINUTES',	33, 6, 'U', 'LE', 0, 1, 'MM'),...
	CANMsgSignal('SECONDS',	41, 6, 'U', 'LE', 0, 1, 'SS'),...
	CANMsgSignal('COMPASS',	49, 4, 'U', 'LE', 0, 45, '�'),...
	CANMsgSignal('PDOP',	57, 5, 'U', 'LE', 0, 0.2, ''),...
	CANMsgSignal('FLTGPS',	62, 1, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('INF',		63, 1, 'U', 'LE', 0, 1, ''),...
	]);...
	% GPS 3
	CANMsgDef('0x06F','Ford Fusion Steer-By-Wire - GPS 3',[...
	CANMsgSignal('ALTITUDE',	01, 16, 'S', 'LE', 0, 0.25, 'm'),...
	CANMsgSignal('HEADING',		17, 16, 'U', 'LE', 0, 0.01, '�'),...
	CANMsgSignal('SPEED',		33, 08, 'U', 'LE', 0, 1, 'MPH'),...
	CANMsgSignal('HDOP',		41, 05, 'U', 'LE', 0, 0.2, ''),...
	CANMsgSignal('VDOP',		49, 05, 'U', 'LE', 0, 0.2, ''),...
	CANMsgSignal('QUALITY',		57, 03, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('NUMSATS',		60, 05, 'U', 'LE', 0, 1, ''),...
	]);...
	% Fuel Level
	CANMsgDef('0x072','Ford Fusion Steer-By-Wire - Fuel Level',[...
	CANMsgSignal('FUEL',	01, 16, 'S', 'LE', 0, 0.108696, '%'),...
	]);...
	% Brake Info
	CANMsgDef('0x074','Ford Fusion Steer-By-Wire - Brake Info',[...
	CANMsgSignal('BRKTRQR',	 1, 12, 'S', 'LE', 0, 1, 'Nm'),...
	CANMsgSignal('HSASTAT',	13,  3, 'S', 'LE', 0, 4, ''),...
	CANMsgSignal('STATNRY',	16,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('BRKTRQA',	17, 12, 'S', 'LE', 0, 1, 'Nm'),...
	CANMsgSignal('HSAMODE',	29,  2, 'S', 'LE', 0, 4, ''),...
	CANMsgSignal('PBRAKE',	31,  2, 'S', 'LE', 0, 0.035, ''),...
	CANMsgSignal('WHLTRQ',	33, 14, 'S', 'LE', 0, 1, 'Nm'),...
	CANMsgSignal('AOG',		49, 10, 'S', 'LE', 0, 1, 'm/s�'),...
	CANMsgSignal('ABSA',	58,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('ABSE',	59,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('STABA',	60,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('STABE',	61,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('TRACA',	62,  1, 'S', 'LE', 0, 1, ''),...
	CANMsgSignal('TRACE',	63,  1, 'S', 'LE', 0, 1, ''),...
	]);...
	% Throttle Info
	CANMsgDef('0x075','Ford Fusion Steer-By-Wire - Throttle Info',[...
	CANMsgSignal('RPM',		 1, 16, 'S', 'LE', 0, 0.25, 'RPM'),...
	CANMsgSignal('APEDPC',	17, 10, 'S', 'LE', 0, 0.10, '%'),...
	CANMsgSignal('APEDRATE',33,  8, 'S', 'LE', 0, 0.04, '%/ms'),...
	]);...
	% Version
	%	is already defined in canMsgDef_Dataspeed_ADASKit_BTBW()
	];


end%fcn