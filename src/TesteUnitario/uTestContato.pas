unit uTestContato;

interface
uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils,
  Vcl.Forms, DUnitX.TestFramework, REST.Response.Adapter,
  REST.Client, REST.Types, REST.Json, System.JSON;

type

  [TestFixture]
  TestTestProvatecContato = class(TTestCase)
  strict private
    FRESTClient1: TRESTClient;
    FRESTRequest1: TRESTRequest;
    FRESTResponse1: TRESTResponse;
    FRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  public
    [Setup]
    procedure SetUp; override;
    [TearDown]
    procedure TearDown; override;

  published
    procedure TestIncluir;
    procedure TesteAlterar;
    procedure TesteExcluir;

  end;

implementation

{ TestTestProvatecContato }

procedure TestTestProvatecContato.SetUp;
begin
  FRESTClient1  := TRESTClient.Create(nil);
  FRESTRequest1 := TRESTRequest.Create(nil);
  FRESTResponse1:= TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  {SETUP}
  FRESTRequest1.Client:= FRESTClient1;
end;

procedure TestTestProvatecContato.TearDown;
begin
  FRESTClient1.Free;
  FRESTRequest1.Free;
  FRESTResponse1.Free;
  FRESTResponseDataSetAdapter.Free;
end;

procedure TestTestProvatecContato.TesteAlterar;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='contatoupdate';
    FRESTRequest1.Method       := rmPUT;
    oJson := TJSONObject.Create;
    oJson.AddPair('id_contato' , '8');
    oJson.AddPair('nome'       , 'CONTATO TESTE TESTANDO');
    oJson.AddPair('data_nasc'  , FormatDateTime('dd/mm/yyyy',NOW));
    oJson.AddPair('idade'      , '50');
    oJson.AddPair('telefone'   , '99999999999');
    oJson.AddPair('id_cliente' , '15');
    FRESTRequest1.AddBody(oJson);
    FRESTRequest1.Execute;
  finally
    oJson.Free;
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecContato.TesteExcluir;
begin
  try
    FRESTClient1.BaseURL := 'http://localhost:9000/contatodeletebyid/' + '8';
    FRESTRequest1.Method := rmDELETE;
    FRESTRequest1.Execute;
  finally
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecContato.TestIncluir;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='contatoinsert';
    FRESTRequest1.Method       := rmPOST;
    oJson := TJSONObject.Create;
    oJson.AddPair('nome'       , 'CONTAT TESTE');
    oJson.AddPair('data_nasc'  , FormatDateTime('dd/mm/yyyy',NOW));
    oJson.AddPair('idade'      , '50');
    oJson.AddPair('telefone'   , '(99999999999)');
    oJson.AddPair('id_cliente' , '15');
    FRESTRequest1.AddBody(oJson);
    FRESTRequest1.Execute;
  finally
    oJson.Free;
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

initialization
  RegisterTest(TestTestProvatecContato.Suite);

end.
