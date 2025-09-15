%% Q2

load('config.mat');
config.issynch = 'false';
config.ismodulate = 'false';
config.K = 10^4;
infobits = rand(1,config.ninfobits) > 0.5;
BPSKbits = 1-2*infobits;
PulseTrain = upsample(BPSKbits,config.Ts);
txpulse = config.tpulserect;

%2A
figure;
plot(txpulse);
title('TPulseRect');

TXFiltout = conv(txpulse,PulseTrain);
PT32 = PulseTrain(1:32*config.Ts);

%2B
figure;
subplot(2,1,1);
plot(PT32);
xlim([0,32*config.Ts]);
title('PulseTrain 32bit - RECT');
subplot(2,1,2);
plot(TXFiltout(1:32*config.Ts));
xlim([0,32*config.Ts]);
title('TXFiltout 32bit - RECT');

txpulse = config.tpulsesinc;

%2C
figure;
plot(txpulse);
title('TPulseSinc');

TXFiltout = conv(txpulse,PulseTrain);
PT32 = PulseTrain(1:32*config.Ts);

%2D
figure;
subplot(2,1,1);
plot(PT32);
xlim([0,32*config.Ts]);
title('PulseTrain 32bit - sinc');
subplot(2,1,2);
plot(TXFiltout(1:32*config.Ts));
xlim([0,32*config.Ts]);
title('TXFiltout 32bit - sinc');

%% Q3
load('config.mat');
config.issynch = 'false';
config.ismodulate = 'false';
config.K = 10^4;
infobits = rand(1,config.ninfobits) > 0.5;
config.pulsetype = 'sinc';
snrDB = [100, 40, 12];
ChannelInVec = TX(config,infobits);
for i = 1:length(snrDB)
    config.snrdB = snrDB(i);
    ChannelOutVec = ChannelTXRX(config,ChannelInVec);
    figure;
    subplot(2,1,1);
    plot(ChannelInVec(1:4*config.Fs));
    title('ChannelInVec - sinc');
    subplot(2,1,2);
    plot(ChannelOutVec(1:4*config.Fs));
    title('ChannelOutVec - sinc');
end

%% Q4
load('config.mat');
config.issynch = 'false';
config.ismodulate = 'false';
config.K = 10^4;
%prepare for 4A
config.snrdB = 100;
infobits = rand(1,config.ninfobits) > 0.5;
config.pulsetype = 'rect';
%Simulation of the system
ChannelInVec = TX(config,infobits);
ChannelOutVec = ChannelTXRX(config,ChannelInVec);
rxbits = RX(config,ChannelOutVec);
%checking BER
BER = mean(infobits~=rxbits);
fprintf('BER IS: ')
disp(BER);

% 4C
Q4_helper(config,infobits,ChannelInVec);

%4A
txpulse = config.tpulserect;
txpulseRev = txpulse(end:-1:1);
matchedRec = filter(txpulseRev,1,ChannelOutVec);
chunk = matchedRec(config.Fs + length(txpulse) - 4000: config.Fs + length(txpulse) + 4000);
figure;
hold on;
plot(matchedRec(config.Fs + length(txpulse) - 4000: config.Fs + length(txpulse) + 4000));
hold on;
plot(4000,matchedRec(config.Fs + length(txpulse)), '*');
title('The Output of the matched filter')

% Prepre for 4C
load('RefInputRect.mat');
config.pulsetype = 'rect';
infobits = infobits(:)';
ChannelOutVec = ChannelOutVec(:)';
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits~=rxbits);
fprintf('BER of C: ')
disp(BER);


% 4D
config.pulsetype = 'sinc';
%Simulation of the system
ChannelInVec = TX(config,infobits);
ChannelOutVec = ChannelTXRX(config,ChannelInVec);
rxbits = RX(config,ChannelOutVec);
%checking BER
BER = mean(infobits~=rxbits);
fprintf('BER IS: ')
disp(BER);
% 4E
Q4_helper(config,infobits,ChannelInVec);

%Prepre for 4E
load('RefInputSinc.mat');
% txpulse = config.tpulsesinc;
infobits = infobits(:)';
ChannelOutVec = ChannelOutVec(:)';
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits~=rxbits);
fprintf('BER of E: ')
disp(BER);

%% Q5

%From here, the pulse will always sinc
load('config.mat');
config.pulsetype = 'sinc';
config.issynch = 'true';
config.ismodulate = 'false';

%5C
config.K = 10^4;
config.snrdB = 100;
infobits = rand(1,config.ninfobits) > 0.5;  
ChannelInVec = TX(config,[config.synchbits,infobits]);
ChannelOutVec = ChannelTXRX(config,ChannelInVec);
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits ~=rxbits);
fprintf('BER IS ');
disp(BER);

%5D
infobits = load('RefInputSynch.mat').infobits;
ChannelOutVec = load('RefInputSynch.mat').ChannelOutVec;
infobits = infobits(:)';
ChannelOutVec = ChannelOutVec(:)';
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits ~=rxbits);
fprintf('BER OF D IS')
disp(BER);

%5E
infobits = rand(1,config.ninfobits) > 0.5;  
ChannelInVec = TX(config,[config.synchbits,infobits]);
Q5_helper(config,infobits,ChannelInVec);

%% Q6

load('config.mat');
config.pulsetype = 'sinc';
config.issynch = 'true';
config.ismodulate = 'true';
config.K = 10^4;
config.snrdB = 100;

% 6A
infobits = rand(1,config.ninfobits) > 0.5;  
ChannelInVec = TX(config,[config.synchbits,infobits]);
ChannelOutVec = ChannelTXRX(config,ChannelInVec);
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits ~=rxbits);
fprintf('BER IS: ');
disp(BER);

% 6B
load('RefInputMod.mat');
infobits = infobits(:)';
ChannelOutVec = ChannelOutVec(:)';
rxbits = RX(config,ChannelOutVec);
BER = mean(infobits ~=rxbits);
fprintf('BER OF 6B IS')
disp(BER);

%6C
infobits = rand(1,config.ninfobits) > 0.5;  
ChannelInVec = TX(config,[config.synchbits,infobits]);
Q5_helper(config,infobits,ChannelInVec)

%% Q7
load('config.mat');
config.ismodulate = 'true';
config.K = 200;
config.snrdB = 100;
config.pulsetype = 'sinc';
config.issynch = 'true';
ChannelOutVec = load('RefInputAudio.mat').ChannelOutVec;
ChannelOutVec = ChannelOutVec(:)';
rxbits = RX(config,ChannelOutVec);
currStr = bitstream2text(rxbits);
disp(currStr);


%% Functions:

function ChannelInVec = TX(config,infobits)
    infobits = infobits(:)';
    if strcmp(config.pulsetype, 'rect')
        txpulse = config.tpulserect;
    elseif strcmp(config.pulsetype,'sinc')
        txpulse = config.tpulsesinc;
    end
    BPSKbits = 1-2*infobits;
    PulseTrain = upsample(BPSKbits,config.Ts);
    TXFiltout = conv(txpulse,PulseTrain);
    ChannelInVec = [zeros(1,config.Fs), TXFiltout, zeros(1,4*config.Fs)];
    if strcmp(config.ismodulate, 'true')
        n=1:length(ChannelInVec);
        ChannelInVec = ChannelInVec.*cos((n.*2*pi*config.Fc)/(config.Fs));
    end
end

function ChannelOutVec = ChannelTXRX(config,ChannelInVec)
    ChannelInVec = ChannelInVec(:)';
    NoiseVec = randn(1,length(ChannelInVec))*10^(-config.snrdB/20);
    ChannelOutVec = ChannelInVec + NoiseVec;
end

function rxbits = RX(config,ChannelOutVec)
if strcmp(config.pulsetype, 'rect')
    txpulse = config.tpulserect;
elseif strcmp(config.pulsetype,'sinc')
    txpulse = config.tpulsesinc;
end
if strcmp(config.ismodulate, 'true')
    n=1:length(ChannelOutVec);
    ChannelOutVec = ChannelOutVec.*cos((2*pi*config.Fc.*n)/(config.Fs));
    ChannelOutVec = conv(config.RxLPFpulse,ChannelOutVec);
end
if strcmp(config.issynch,'true')
    %step 1
    synchsymbol = config.synchsymbol(end:-1:1);
    matched_filter_out = filter(synchsymbol,1,ChannelOutVec);
    [max_value, N_opt] = max(abs(matched_filter_out(1:4*config.Fs)));
    % step 2
    N_opt = N_opt - length(config.synchsymbol) + config.Ts*config.nsynchbits + length(txpulse);
end
matchedRec = filter(txpulse(end:-1:1),1,ChannelOutVec);
sample_factor = config.Fs / config.B;
if strcmp(config.issynch,'true')
    rxbits = matchedRec(N_opt:config.Ts:N_opt+config.Ts*(config.K - 1));
    if strcmp(config.ismodulate, 'true')
        % Estimate beta - for Q6
        betaDivide2 = max_value/norm(config.synchsymbol,2);
        if matched_filter_out(N_opt) < 0
            rxbits = rxbits * (-1);
        end
        fprintf('Beta/2 IS')
        disp(betaDivide2);
    end
else
    matchedRecKat = matchedRec(config.Fs + length(txpulse):config.Fs + length(txpulse) + config.Ts*(config.K - 1));
    rxbits = downsample(matchedRecKat,sample_factor);
end
rxbits(rxbits > 0) = 0;
rxbits(rxbits < 0) = 1;
end

function Q4_helper(config,infobits,ChannelInVec)
    % % SNR[dB] values
    snrDB = [-12, -9, -6, -3, 0 , 3, 6, 9 , 12];
    ber_vec = zeros(1, length(snrDB));
    for i = 1:length(snrDB)
        config.snrdB = snrDB(i);
        ChannelOutVec = ChannelTXRX(config,ChannelInVec);
        rxbits = RX(config,ChannelOutVec);
        ber_vec(i) = mean(infobits~=rxbits);
    end
    figure;
    semilogy(snrDB,ber_vec);
    grid on;
    title("SNR vs. BER (Log Scale)");
    xlabel("SNR[dB]");
    ylabel("BER");
    legend('SNR vs. BER');
end

function Q5_helper(config,infobits,ChannelInVec)
    snrDB = [-12, -9, -6, -3, 0 , 3, 6, 9 , 12];
    ber_vec = zeros(1, length(snrDB));
    for i = 1:length(snrDB)
        config.snrdB = snrDB(i);
        ChannelOutVec = ChannelTXRX(config,ChannelInVec);
        rxbits = RX(config,ChannelOutVec);
        ber_vec(i) = mean(infobits~=rxbits);
    end
    figure;
    semilogy(snrDB,ber_vec);
    grid on;
    title("SNR vs. BER (Log Scale)");
    xlabel("SNR[dB]");
    ylabel("BER");
    legend('SNR vs. BER');
end