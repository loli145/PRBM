load("Vishid.mat")
N_slm_y = 824;
numhid = 196;
spin_N = 196;
nx_1 = 10;
ny_1 = 4;
hiden_states = ones(1,numhid);
visib_states = 2*randi(2,[1,spin_N])-3;
c = max(max(abs(vishid)));
nn = 10;
Ksi_hid = ones(spin_N+nn,numhid)*c;
Ksi_hid(nn+1:end,:) = vishid;
phase_pic = EncodeEachJ_newencoding(Ksi_hid,visib_states,hiden_states,nn,ny_1,nx_1,N_slm_y,c,numhid) ;
figure;imagesc(phase_pic);

%%
function [phase_pic] = EncodeEachJ_newencoding(Ksi_hid,visib_states,hiden_states,nn,ny_1,nx_1,N_slm_y,c,numhid) 
S_hid = kron(angle(hiden_states),ones(nn*ny_1,nx_1));
S_vis = kron(angle(visib_states'),ones(ny_1,numhid*nx_1));
Phase = [S_hid;S_vis];
Amplitude = kron(acos(Ksi_hid/c),ones(ny_1,nx_1));
theta1 = Phase + Amplitude;
theta2 = Phase - Amplitude;
M1 = mod(repmat((1:numhid*nx_1)',1,N_slm_y) + repmat((1:N_slm_y),numhid*nx_1,1),2);
M2 = 1 - M1;
phase_pic =  M1' .* theta1 + M2' .*theta2;
phase_pic = mod(phase_pic,2*pi);
end


