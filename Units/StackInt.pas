unit StackInt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TStackInt = class(TObject)
    private
      max_size:integer;
      stack:array [0..1023] of integer;
      sp:integer;
      error:integer;
    public
      constructor init;
      procedure push(x:integer);
      function pop:integer;
      function IsEmpty:boolean;
      function IsFull:boolean;
      function size:integer;
      function elementAt(i:integer):integer;
  end;

implementation

constructor TStackInt.init;
begin
  max_size:=1024;
  sp:=0;
  error:=-1;
end;

function TStackInt.IsEmpty:boolean;
begin
  IsEmpty:=sp=0;
end;

function TStackInt.IsFull:boolean;
begin
  if sp=(max_size-1) then
    IsFull:=true
  else
    IsFull:=false;
end;

procedure TStackInt.push(x:integer);
begin
  if not IsFull then begin
    stack[sp]:=x;
    inc(sp);
  end;
end;

function TStackInt.pop:integer;
begin
  if not IsEmpty then begin
    dec(sp);
    pop:=stack[sp];
  end
  else
    pop:=error;
end;

function TStackInt.size:integer;
begin
  size:=sp-1;
end;

function TStackInt.elementAt(i:integer):integer;
begin
  if (i<=sp)and(i>=0) then
    elementAt:=stack[i]
  else
    elementAt:=error;
end;

end.
