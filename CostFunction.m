function Cost = CostFunction( x )
global pt;
key=round(x)*ones(1,16);
s = aesinit(key);
ct = aes(s, 'enc', 'ecb', pt);
sig= round((aes(s, 'dec', 'ecb', ct)));
Cost=x;
end

