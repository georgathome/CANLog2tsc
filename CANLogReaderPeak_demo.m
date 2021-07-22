clc
clear

% Log file names
filename = "testPeak00.trc";

logrdr = CANLogReaderPeak(filename);
disp(logrdr)


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
msgs = logrdr.read(1:1e2);
toc
disp(msgs)

%% Conver2tsc
msgdef = [...
	canMsgDef_Mobileye_630()
	canMsgDef_Dataspeed_ADASKit_BTBW()
	canMsgDef_Dataspeed_ADASKit_SBW()
	];
S1 = logrdr.convert2tsc(msgdef, 1:100);
S2 = logrdr.convert2tsc(msgdef);


%% ADAS Kit
subplot(4,1,1)
plot(S2.msg_0x064.EN);
title(S2.msg_0x064.Name)
grid on

subplot(4,1,2)
plot(S2.msg_0x065.ANGLE);
title(S2.msg_0x065.Name)
grid on

subplot(4,1,3)
plot(S2.msg_0x065.SPEED);
title(S2.msg_0x065.Name)
grid on

subplot(4,1,4)
plot(S2.msg_0x065.TORQUE);
title(S2.msg_0x065.Name)
grid on


%% Mobileye
subplot(5,1,1)
plot(S2.msg_0x766.Quality, 'DisplayName','left'); hold on
plot(S2.msg_0x768.Quality, 'DisplayName','right'); hold off
ylabel('Quality')
legend('show')
grid on

subplot(5,1,2)
plot(S2.msg_0x766.ModelDegree, 'DisplayName','left'); hold on
plot(S2.msg_0x768.ModelDegree, 'DisplayName','right'); hold off
ylabel('Model Degree')
legend('show')
grid on

subplot(5,1,3);
plot(S2.msg_0x766.LaneType,'DisplayName','left'); hold on
plot(S2.msg_0x768.LaneType,'DisplayName','right'); hold off
ylabel('Marking Type')
legend('show')
grid on

subplot(5,1,4)
plot(S2.msg_0x766.Width, 'DisplayName','left'); hold on
plot(S2.msg_0x768.Width, 'DisplayName','right'); hold off
ylabel('Width')
legend('show')
grid on

subplot(5,1,5)
plot(S2.msg_0x767.ViewRange, 'DisplayName','left'); hold on
plot(S2.msg_0x769.ViewRange, 'DisplayName','right'); hold off
ylabel('View Range')
legend('show')
grid on
