clear;
clc;
% Generator Matrix for Golay(23,12,7)
P=[1 1 0 0 0 1 1 1 0 1 0;
   0 1 1 0 0 0 1 1 1 0 1;
   1 1 1 1 0 1 1 0 1 0 0;
   0 1 1 1 1 0 1 1 0 1 0;
   0 0 1 1 1 1 0 1 1 0 1;
   1 1 0 1 1 0 0 1 1 0 0;
   0 1 1 0 1 1 0 0 1 1 0;
   0 0 1 1 0 1 1 0 0 1 1;
   1 1 0 1 1 1 0 0 0 1 1;
   1 0 1 0 1 0 0 1 0 1 1;
   1 0 0 1 0 0 1 1 1 1 1;
   1 0 0 0 1 1 1 0 1 0 1];

% Creating the Generator Matrix
G = [eye(12) P];

% Parity check Matrix for Golay(23,12,7)
H = [transpose(P) eye(11)];

%Getting the message from user
m = input("Enter the message: ");
%To use hard coded message uncomment it (for quick test)
%m = [1 1 0 1 1 0 0 0 1 1 0 0];
disp("m:");
disp(m);

%Coding the message
c = BMM(m,G);
disp("C:");
disp(c);

%Adding random error
e=zeros(1,23);
n_e_b=randi(3);
for i=1:3
    index=randi(23);
    e(index)=1;
end
%For 4 bit error test uncomment below line
%e=[1 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
r = xor(c,e);

disp("Received Message:");
disp(r);

% Calculating the syndrome
HT = transpose(H);
s = BMM(r,transpose(H));


disp("Syndrome for received message");
disp(s);
cursor=1;
%Syndrome Table for 1 Error
for i=1:23
    Error(i,:)=zeros(1,23);
    Error(i,i)=1;
    Syndromes(i,:)=BMM(Error(i,:),HT);
    cursor=cursor+1;
end
clear i;
%Syndrome Table for 2 Error
for j=1:23
    for k=j+1:23
        Error(cursor,:)=zeros(1,23);
        Error(cursor,j)=1;
        Error(cursor,k)=1;
        Syndromes(cursor,:)=BMM(Error(cursor,:),HT);
        cursor=cursor+1;
    end
end
clear j k;
%Syndrome Table for 3 Error
for x=1:23
    for y=x+1:23
        for z=y+1:23
        Error(cursor,:)=zeros(1,23);
        Error(cursor,x)=1;
        Error(cursor,y)=1;
        Error(cursor,z)=1;
        Syndromes(cursor,:)=BMM(Error(cursor,:),HT);
        cursor=cursor+1;
        end
    end
end
clear x y z;
%disp("Error List:");
%disp(Error);
%disp("Syndromes");
%disp(Syndromes);

for a=1:cursor-1
    if(s==Syndromes(a,:))
        corrected_r = xor(r,Error(a,:));
    end
end
disp("Received Message:");
disp(r);
disp("Corrected r:");
disp(corrected_r);
received_message=corrected_r(1,1:12);
disp("Original Message");
disp(received_message);

