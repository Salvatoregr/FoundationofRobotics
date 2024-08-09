function [pe, ped, pedd] = CIRCOLARE ( sc, scd, scdd, c, ro, pe, ped, pedd, l, S_new)
        
        %l = di quanti campioni sto anticipando 
        len=length(sc)-1; %Quello è uno.
        temp = zeros(length(S_new),3);
        
        %Formule 4.39 , 4.40 e 4.41 ma in realtà sono le 4.44 e 4.45
        pc = c + [ro*cos(sc/ro)     ro*sin(sc/ro)     zeros(length(sc),1)];
        
        pcd = [-1*scd.*sin(sc/ro) ...
               scd.*cos(sc/ro) ...
               zeros(length(sc),1)];
        
        pcdd = [-1*scdd.*sin(sc/ro)-((scd).^2).*cos(sc/ro)/ro ...
                scdd.*cos(sc/ro)- ((scd).^2).*sin(sc/ro)/ro ...
                zeros(length(sc),1)];
            
        %Parto dalla lunghezza del tratto fino alla fine del tratto. Prima
        %saranno tutti 0 perché questo tratto circolare non contribuisce
        %alla traiettoria.
        
        %Anticipo della traiettoria a mano per il tratto circolare.
        temp((l-len):l,:) = pc;
        temp (l+1:end,:)  = temp (l+1:end,:) + pc(end,:); %Gli sto passando solo l'ultima riga di pc   
        %Glielo somma per una fatto dimensionale il temp a destra ma non serve a niente , sono tutti zeri 
        %alla fine.
                                                            
        
        pe(l-len:end,:) = temp(l-len:end,:);
        ped(l-len:l,:)=pcd;
        pedd(l-len:l,:)=pcdd;

end