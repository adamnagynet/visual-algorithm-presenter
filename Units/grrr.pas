         {***}program szekvencialis;
         var i,n,mit:integer;et:array[1..10] of integer;
         begin
              readln(n);beolvastomb;readln(mit);i:=1;
              while (i<=n) and (mit<>et[i]) do inc(i);
              if i>n then write('A ',mit,' nem szerepel a t”mbben!')
              else write('A ',mit,' az ',i,'-ik pozic¡¢n tal lhat¢!');
         end.
         {***}program binaris_kereses;
         var i,n,e,u,k,mit:integer;et:array [1..10] of integer;
         begin
              readln(n);beolvast; readln(mit);e:=1;u:=n;
              repeat k:=(e+u) div 2; if mit<et[k[] then u:=k-1
              	else if mit>et[k] then e:=k+1;
              until (e>u)or(mit=et[k]);
              if e>u then write('A',mit,'nem szerepel a t”mbben!')
              else write('A',mit,'a/az,'k',. pozici¢n tal lhat¢!');
         end.
         {***}program buborek;
         var i,k,n,seged:integer;et:array [1..10] of integer;
             mutato:boolean;
         begin
              beolvast;k:=0;
         	repeat mutato:=true;
                    for i:=1 to n-k-1 do
                        if et[i]>et[i+1] then begin
                           seged:=et[i];
                           et[i]:=et[i+1];
                           et[i+1]:=seged;
                           mutato:=false;
                        end;inc(k);until mutato;
              for i:=1 to n do write(et[i]:3);end.
         {***}program beszurasosrendezes;
         var i,j,n,be:integer;et:array[1..10] of integer;
         begin
              beolvat for i:=2 to n do begin
                  j:=i-1; be:=et[i];
                  while (j>0)and(be<et[j]) do begin
                        et[j+1]:=et[j]; dec(j); end;
                  et[j+1]:=be; end;
              for i:=1 to n do write(et[i]:3);
         end.
         {***}program minrendezes;
         var i,j,n,min,hol:integer; et:array[1..10] of integer;
         begin
              beolvt for i:=1 to n do begin
                  min:=et[i]; hol:=i;
                  for j:=i+1 to n do
                      if et[j]<min then begin
                         min:=et[j]; hol:=j;
                      end; et[hol]:=et[i]; et[i]:=min;
              end; for i:=1 to n do write(et[i]:3);
         end.
         {***}program szamolasosrendezes;
         var i,j,n:integer;et,index,uj:array [1..10] of integer;
         begin
              beolvt for i:=1 to n do index[i]:=1;
              for i:=2 to n do for j:=1 to i-1 do
                      if et[i]>et[j] then inc(index[i])
                      else inc(index[j]);
              for i:=1 to n do uj[index[i]]:=et[i];
              et:=uj; for i:=1 to n do write(et[i]:3);
         end.
         
