unit uDatamodulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Vcl.Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmDatamodulo = class(TDataModule)
    dsPesquisa: TDataSource;
    dsClientes: TDataSource;
    dsContatos: TDataSource;
    DBConect: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    QryAux: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gblValCodigo,
    gblValNome  : string;
    function CharEspeciais(Texto:String):String;
  end;

var
  frmDatamodulo: TfrmDatamodulo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TfrmDatamodulo.CharEspeciais(Texto: String): String;
var
  i,t:integer;
begin
  t:=length(texto);
  i:=1;
  While i <= t do
    begin
     if texto[i] in ['0'..'9','a'..'z','A'..'Z',#32] Then
       result:=result+Texto[i];
     i:=i+1;
    end;
end;

procedure TfrmDatamodulo.DataModuleCreate(Sender: TObject);
begin
  //FDPhysPgDriverLink1.VendorLib := ExtractFilePath(Application.ExeName)+'libpq.dll';
end;

end.
