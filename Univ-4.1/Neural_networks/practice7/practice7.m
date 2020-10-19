x=linspace(-1,1,5);
y=linspace(0,5,5);
z=linspace(1,5,5);

counter=1;
p={};
t={};
for a=x
    for b=y
        for c=z
            p{counter}=[a; b; c];
            t{counter}=[a*a+2*a*b+sqrt(c)];
            counter=counter+1;
        end
    end
end

nwt=newrbe(p,t)