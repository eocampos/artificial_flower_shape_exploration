% This code generates graphs representing simplified "flower" structures
% using three shape parameters: width, height, and curvature
% ===================
% (Block 1)
% This block prompts user input in the Command Window for (hopefully)
% easier manual exploration of parameter space
%
% PetalWidth = input('Flower Petal Width (positive numbers only): ');
% Height = input('Flower Height (positive numbers only): ');
% Curvature = input('Curvature Parameter (positive or negative numbers ok): '); % negative values give trumpet shape; 0 gives cone; positive values give bowl shape
% CentralRadius = input('Central Radius (positive numbers only): ');
% RotationSteps = input('Number of rotation steps (slices) to execute: ');
% ConcentricSteps = input('Number of concentric steps (rings) to execute: ');
% Thickness = input('Thickness of flower surface: '); % approximate distance between inner and outer "shells" (surfaces)
% disp(' ');
% ====================
% (Block 2)
PetalWidth = 26.25;
Height = 30;
Curvature = -1.5; % negative values give trumpet shape; 0 gives cone; positive values give bowl shape
CentralRadius = 1.25;
RotationSteps = 12;
ConcentricSteps = 20; % set to 20 for nice results
Thickness = 0.1; % approximate distance between inner and outer "shells" (surfaces)
% Make sure that either the coding regions of Block 1 or Block 2 are commented out before executing
% ====================
theta = 0:(2*pi)/RotationSteps:2*pi;
% Main shell (or inner surface)
r = (CentralRadius:(PetalWidth)/ConcentricSteps:PetalWidth+CentralRadius);
z = (Height*(((1/PetalWidth)*(r-CentralRadius)).^((exp(1)).^Curvature)));
%
xx = bsxfun(@times,r',cos(theta));
yy = bsxfun(@times,r',sin(theta));
zz = repmat(z',1,length(theta));

% ====================
% Outer shell (or surface)
r_2 = (CentralRadius+Thickness:(PetalWidth)/ConcentricSteps:PetalWidth+CentralRadius+Thickness);
z_2 = (-Thickness)+(Height*(((1/PetalWidth)*(r-CentralRadius)).^((exp(1)).^Curvature)));
%
xx_2 = bsxfun(@times,r_2',cos(theta));
yy_2 = bsxfun(@times,r_2',sin(theta));
zz_2 = repmat(z_2',1,length(theta));

% create upper curtain
r_upper_curtain = (PetalWidth+CentralRadius):Thickness:(PetalWidth+CentralRadius+Thickness);
z_upper_curtain = Height+(-(r_upper_curtain-(PetalWidth+CentralRadius)));
xx_upper_curtain = bsxfun(@times,r_upper_curtain',cos(theta));
yy_upper_curtain = bsxfun(@times,r_upper_curtain',sin(theta));
zz_upper_curtain = repmat(z_upper_curtain',1,length(theta));

% r_upper_curtain = 4:3:7;
% z_upper_curtain = -r_upper_curtain;
% xx_upper_curtain = bsxfun(@times,r_upper_curtain',cos(theta));
% yy_upper_curtain = bsxfun(@times,r_upper_curtain',sin(theta));
% zz_upper_curtain = repmat(z_upper_curtain',1,length(theta));

% Create lower curtain
r_lower_curtain = CentralRadius:Thickness:CentralRadius+Thickness;
z_lower_curtain = -(r_lower_curtain-CentralRadius);
xx_lower_curtain = bsxfun(@times,r_lower_curtain',cos(theta));
yy_lower_curtain = bsxfun(@times,r_lower_curtain',sin(theta));
zz_lower_curtain = repmat(z_lower_curtain',1,length(theta));

% %Add inner, top ring to outer shell:
% xx_2 = [xx_2;xx(size(xx,1),:)];
% yy_2 = [yy_2;yy(size(yy,1),:)];
% zz_2 = [zz_2;zz(size(zz,1),:)];
% 
% %Add outer, bottom ring to inner shell:
% xx = [xx_2(1,:);xx];
% yy = [yy_2(1,:);yy];
% zz = [zz_2(1,:);zz];



% ====================
% Reshapes the above matrices into single columns of coordinates:
% x_column = reshape(xx,(RotationSteps+1)*(ConcentricSteps+2),1);
% y_column = reshape(yy,(RotationSteps+1)*(ConcentricSteps+2),1);
% z_column = reshape(zz,(RotationSteps+1)*(ConcentricSteps+2),1);
% ====================
% Reshapes the above matrices into single columns of coordinates:
% x_column_2 = reshape(xx_2,(RotationSteps+1)*(ConcentricSteps+2),1);
% y_column_2 = reshape(yy_2,(RotationSteps+1)*(ConcentricSteps+2),1);
% z_column_2 = reshape(zz_2,(RotationSteps+1)*(ConcentricSteps+2),1);
% ====================
























% Vertically concatenates the columns from each shell along each axis:
% total_x_column = [x_column; x_column_2];
% total_y_column = [y_column; y_column_2];
% total_z_column = [z_column; z_column_2];
% ====================
% Concatenates the three columns above into an x,y,z matrix:
% concat_matrix = horzcat(total_x_column,total_y_column,total_z_column);
% ====================




% plots the two surfaces to get an idea of the final "thickness" of the object:
figure(1)
surf(xx,yy,zz)
hold on
surf(xx_2,yy_2,zz_2)
surf(xx_upper_curtain,yy_upper_curtain,zz_upper_curtain)
surf(xx_lower_curtain,yy_lower_curtain,zz_lower_curtain)
view(90,0)
axis equal
hold off

% ====================
% plots a single surface:
% figure (2)
% surf(xx,yy,zz)
% axis equal
% ====================
% plots the point cloud of the two surfaces:
% figure(3)
% scatter3(total_x_column,total_y_column,total_z_column,10,'o','filled')
% axis equal
% figure(4)
% surf(xx_upper_curtain,yy_upper_curtain,zz_upper_curtain)
% hold on
% surf(xx_lower_curtain,yy_lower_curtain,zz_lower_curtain)
% axis equal
% hold off

figure(5)
plot(r,z)
axis equal