clc
clear

% Log file names
filename = "testASC00.asc";

logrdr = CANLogReaderASC(filename);
disp(logrdr);


%%% Run Tests
%% table()
tic
t = logrdr.table();
toc
head(t)

%% timetable()
tic
tt = logrdr.timetable();
toc
head(tt)

%% read()
tic
msgs = logrdr.read();
toc
disp(msgs)

%% Conver2tsc
msgdef = [...
	canMsgDef_Mobileye_630()
	canMsgDef_Dataspeed_ADASKit_BTBW()
	canMsgDef_Dataspeed_ADASKit_SBW()
	];
S1 = logrdr.convert2tsc(msgdef, 3, 1:100);
S2 = logrdr.convert2tsc(msgdef, 3);

