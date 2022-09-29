% Waveforms seismogram visualization in elastic medium.
%
% The code is intentionally writen in a single file to simplify start up.
% The program does not save any files, add such option manually if needed.
% Drawing the waveforms or wave trains is the most computationally demanding. 
% --------------------------------------------------------------
% Jimmy Xuekai Li, 2022
% jimmy.li@uq.edu.au
% University of Queensland
% Brisbane, Australia
% --------------------------------------------------------------
% Citation: 
% Li, Jimmy Xuekai, et al. "Wettability-dependent wave velocities and 
% attenuation in granular porous media." Geophysics 87.4 (2022): 1-44.
% --------------------------------------------------------------

close all
clc
clear all
Ap=xlsread('Glassbead_Pwave_ow.xlsx',2,'A2:O2500');% amplitude data
Vpp=xlsread('Glassbead_Pwave_ow.xlsx',1,'G2:I15');% velocity data

tp=Ap(:,1);% P wave time

for ii=2:1:15
ap(:,ii-1)=Ap(:,ii)+100*(ii-16); % 1M P wave amplitude
end

Sw=Vpp(:,1);% water saturation
p=Vpp(:,2);% density
Vp=Vpp(:,3);% P wave velocity

%% mid parameters
figure(1)
plot(tp,abs(ap),'linewidth',1)
text(-20,1430,'S_w = 0%')
text(-20,1330,'S_w = 11%')
text(-20,1230,'S_w = 12%')
text(-20,1130,'S_w = 18%')
text(-20,1030,'S_w = 44%')
text(-20,930,'S_w = 60%')
text(-20,830,'S_w = 73%')
text(-20,730,'S_w = 80%')
text(-20,630,'S_w = 85%')
text(-20,530,'S_w = 90%')
text(-20,430,'S_w = 94%')
text(-20,330,'S_w = 98%')
text(-20,230,'S_w = 99%')
text(-20,130,'S_w = 99.9%')
set(gca,'ytick',[],'linewidth',1,'fontsize',12)
xlabel('Time(¦Ìs)')
ylabel('Amplitude (arbitrary unit)')


figure(2)
yyaxis left
plot(Sw,Vp,'k-o','MarkerSize',10);
xlabel('S_w')
ylabel('V_p (m/s)')
hold on;
yyaxis right
% plot density
plot(Sw,p,'-*','color','g');
ylabel('Density (kg/m^3)')
legend("Vp","Rho",'location','northwest')
grid on


function ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%% 
% tight_subplot creates "subplot" axes with adjustable gaps and margins
%
% ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins 
%
%  out:  ha     array of handles of the axes objects
%                   starting from upper left corner, going row-wise as in
%                   going row-wise as in
%
%  Example: ha = tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])
%           for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
%           set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')

% Pekka Kumpulainen 20.6.2010   @tut.fi
% Tampere University of Technology / Automation Science and Engineering


if nargin<3; gap = .02; end
if nargin<4 || isempty(marg_h); marg_h = .05; end
if nargin<5; marg_w = .05; end

if numel(gap)==1 
    gap = [gap gap];
end
if numel(marg_w)==1 
    marg_w = [marg_w marg_w];
end
if numel(marg_h)==1 
    marg_h = [marg_h marg_h];
end

axh = (1-sum(marg_h)-(Nh-1)*gap(1))/Nh; 
axw = (1-sum(marg_w)-(Nw-1)*gap(2))/Nw;

py = 1-marg_h(2)-axh; 

ha = zeros(Nh*Nw,1);
ii = 0;
for ih = 1:Nh
    px = marg_w(1);

    for ix = 1:Nw
        ii = ii+1;
        ha(ii) = axes('Units','normalized', ...
            'Position',[px py axw axh], ...
            'XTickLabel','', ...
            'YTickLabel','');
        px = px+axw+gap(2);
    end
    py = py-axh-gap(1);
end
end

