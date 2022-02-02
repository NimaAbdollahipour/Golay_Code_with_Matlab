function C= BMM(A,B)
    AR = size(A,1);
    AC = size(A,2);
    BR = size(B,1);
    if(AC ~= BR)
        disp("Matrix Dimentions Error");
    end
    BC = size(B,2);
    C = zeros(AR,BC);
    for i=1:AR
        for j=1:BC
            for k=1:AC
                C(i,j)=xor(C(i,j),A(i,k)*B(k,j));
            end
        end
    end
end


