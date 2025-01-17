function msgComp = canMsgDef_Mobileye_630()
%CANMSGDEF_MOBILEYE_630		Mobileye 630 CAN message definition.
%   
%	MSGCOMP = CANMSGDEF_MOBILEYE_630() returns the CAN message definition
%	for the Mobileye 630 camera sensor.
% 

msgComp = [...
	% TSR
	CANMsgDef('0x720', 'TSR', [...
	CANMsgSignal('SignType',		1,	8, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('SignTypeSupp',	9,	8, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('SignPositionX',	17,	8, 'U', 'LE', 0, 0.5, 'm'),...
	CANMsgSignal('SignPositiony',	25,	8, 'S', 'LE', 0, 0.5, 'm'),...
	CANMsgSignal('SignPositionZ',	33,	8, 'S', 'LE', 0, 0.5, 'm'),...
	CANMsgSignal('FilterType',		41,	8, 'U', 'LE', 0, 1, ''),...
	]);...
	% Obstacle Status
	CANMsgDef('0x738', 'Obstacle Status', [...
	CANMsgSignal('NumObstacles',				1,	8, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('Timestamp',					9,	8, 'U',	'LE', 0, 1, 'ms'),...
	CANMsgSignal('ApplicationVersion',			17,	8, 'U', 'LE', 0, 0.5, ''),...
	CANMsgSignal('ActiveVersionNumberSection',	25,	2, 'U',	'LE', 0, 0.5, ''),...
	CANMsgSignal('LeftCloseRangeCutIn',			27,	1, 'U',	'LE', 0, 0.5, ''),...
	CANMsgSignal('RightCloseRangeCutIn',		28,	1, 'U',	'LE', 0, 1, ''),...
	CANMsgSignal('Go',							29,	4, 'U',	'LE', 0, 0.5, ''),...
	CANMsgSignal('ProtocolVersion',				33,	8, 'U',	'LE', 0, 0.5, ''),...
	CANMsgSignal('CloseCar',					41,	1, 'U',	'LE', 0, 0.5, ''),...
	CANMsgSignal('FailSafe',					42,	4, 'U',	'LE', 0, 0.5, ''),...
	]);...
	% Obstacle Data A
	CANMsgDef('0x739', 'Obstacle Data A', [...
	CANMsgSignal('ObstacleID',			1,	8,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ObstaclePosX',		9,	12,	'U', 'LE', 0, 0.0625, 'm'),...
	CANMsgSignal('ObstaclePosY',		25,	10,	'S', 'LE', 0, 0.0625, 'm'),...
	CANMsgSignal('BlinkerInfo',			35,	3,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CutInAndOut',			38,	3,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ObstacleRelVelX',		41,	12,	'S', 'LE', 0, 0.0625, 'm/s'),...
	CANMsgSignal('ObstacleType',		53,	3,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ObstacleStatus',		57,	3,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ObstacleBrakeLights',	60,	1,	'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ObstacleValid',		63,	2,	'U', 'LE', 0, 1, ''),...
	]);
	% Obstacle Data B
	CANMsgDef('0x73A', 'Obstacle Data B', [...
	CANMsgSignal('ObstacleLength',		1,	8, 'U',	'LE', 0, 0.5, 'm'),...
	CANMsgSignal('ObstacleWidth',		9,	8, 'U',	'LE', 0, 0.05, 'm'),...
	CANMsgSignal('ObstacleAge',			17,	8, 'U',	'LE', 0, 1, 'frames'),...
	CANMsgSignal('ObstacleLane',		25,	2, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('CIPVFlag',			27,	1, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('RadarPosX',			29,	12,'U', 'LE', 0, 0.0625, 'm'),...
	CANMsgSignal('RadarVelX',			41,	12,'S',	'LE', 0, 0.0625, 'm/s'),...
	CANMsgSignal('RadarMatchConfidence',53,	3, 'U',	'LE', 0, 1, ''),...
	CANMsgSignal('MatchedRadarID',		56,	7, 'U',	'LE', 0, 1, ''),...
	]);...
	% Obstacle Data C
	CANMsgDef('0x73B', 'Obstacle Data C', [...
	CANMsgSignal('ObstacleAngleRate',	1,	16, 'S', 'LE', 0, 0.01, '°/s'),...
	CANMsgSignal('ObstacleScaleChange',	17,	16, 'S', 'LE', 0, 1/5e3,'pix/s'),...
	CANMsgSignal('ObstacleAccelX',		33,	10, 'S', 'LE', 0, 0.03, 'm/s^2'),...
	CANMsgSignal('ObstacleReplaced',	44,	1,	'U', 'LE', 0, 1,	''),...
	CANMsgSignal('ObstacleAngle',		49,	16, 'S', 'LE', 0, 0.01, '°'),...
	]);...
	% LKA Left Lane A
	CANMsgDef('0x766','LKA left lane A', [...
	CANMsgSignal('LaneType',			01,  4, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('Quality',				05,  2, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('ModelDegree',			07,  2, 'U', 'LE', 0, 1, ''),...
	CANMsgSignal('PosParameterC0',		09, 16, 'S', 'LE', 0, 1/256, 'm'),...
	CANMsgSignal('CurvParameterC2',		25,	16, 'U', 'LE', -0.031999, 1/1024e3, '1/m'),...
	CANMsgSignal('CurvDerParameterC3',	41, 16, 'U', 'LE', -0.000122067, 3.72529e-09, '1/(m*s)'),...
	CANMsgSignal('Width',				57,  8, 'U', 'LE', 0, 0.01, 'm')]);...
	% LKA Left Lane B
	CANMsgDef('0x767','LKA left lane B', [...
	CANMsgSignal('HeadingAngle',		01,	16, 'U', 'LE', -31.999, 1/1024, 'rad'),...
	CANMsgSignal('ViewRange',			17, 15, 'U', 'LE', 0, 1/256, 'm'),...
	CANMsgSignal('ViewRangeAvailab',	32,  1, 'U', 'LE', 0, 1, ''),...
	]);...
	];
	


%% LKA Right Lane
msgComp(end+1) = CANMsgDef('0x768', 'LKA right lane A', msgComp(6).Signals);
msgComp(end+1) = CANMsgDef('0x769', 'LKA right lane B', msgComp(7).Signals);

%% Next lanes
msgComp(end+1) = CANMsgDef('0x76C', 'Next lane A', msgComp(6).Signals);
msgComp(end+1) = CANMsgDef('0x76D', 'Next lane B', msgComp(7).Signals);
msgComp(end+1) = CANMsgDef('0x76E', 'Next lane A_1', msgComp(6).Signals);
msgComp(end+1) = CANMsgDef('0x76F', 'Next lane B_1', msgComp(7).Signals);

end%fcn
