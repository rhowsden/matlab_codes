disp('First we''ll generate a bunch of 1D Ising samples.');
disp('The rows are unrelated to each other.');

disp('Starting at high temperature ...');
for b=0:0.1:0.5,
  imagesc(ising1(200,20,b,50));
  pause(0);
end;

disp('Moving to medium temperature ...');
for b=0.6:0.2:1.2,
  imagesc(ising1(200,20,b,50));
  pause(0);
end;

disp('Moving to low temperature (running slower, because more iterations needed...)');
for b=1.5:0.3:3,
  imagesc(ising1(200,50,b,50));
  pause(0);
end;

disp(' ');
disp('Press RETURN to move on to 2D example.');
pause;

disp('We''ll try a small 2D case.');
disp('If your computer is fast, you can easily do MUCH larger tests.')

disp('Going from high to low temperature ...');
for b=0:0.05:0.6,
  imagesc(ising2(150,round(10+b*100),b,1));
  pause(0);
end;

disp(' ');
disp('Press RETURN to move on to 3D example.');
pause;

disp('We''ll end with a 3D test.  We''ll generate it first, and');
disp('then plot our way through it slice by slice.');

s=ising3(50,50,3,1);
for i=1:30, imagesc(s(:,:,i)); pause(0.2); end;