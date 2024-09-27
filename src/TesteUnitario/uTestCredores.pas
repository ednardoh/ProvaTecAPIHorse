unit uTestCredores;

interface
uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils,
  Vcl.Forms, DUnitX.TestFramework, REST.Response.Adapter,
  REST.Client, REST.Types, REST.Json, System.JSON;

type

  [TestFixture]
  TestTestProvatecCredores = class(TTestCase)
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

{ TestTestProvatecCredores }

procedure TestTestProvatecCredores.SetUp;
begin
  FRESTClient1  := TRESTClient.Create(nil);
  FRESTRequest1 := TRESTRequest.Create(nil);
  FRESTResponse1:= TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  {SETUP}
  FRESTRequest1.Client:= FRESTClient1;
end;

procedure TestTestProvatecCredores.TearDown;
begin
  FRESTClient1.Free;
  FRESTRequest1.Free;
  FRESTResponse1.Free;
  FRESTResponseDataSetAdapter.Free;
end;

procedure TestTestProvatecCredores.TesteAlterar;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='credorupdate';
    FRESTRequest1.Method       := rmPUT;
    oJson := TJSONObject.Create;
    oJson.AddPair('id'         , TJSONNumber.Create(13));
    oJson.AddPair('cpfcnpj'    , '99999999999999');
    oJson.AddPair('nome'       , 'CREDOR DE TESTE ALTERADO');
    oJson.AddPair('cep'        , '9999999');
    oJson.AddPair('logradouro' , 'RUA TESTE ALTERADO');
    oJson.AddPair('numero'     , '99');
    oJson.AddPair('complemento', 'TESTE ALTERADO');
    oJson.AddPair('bairro'     , 'BAIRRO TESTE ALTERADO');
    oJson.AddPair('cidade'     , 'CIDADE TESTE ALTERADO');
    oJson.AddPair('ibge_cidade', '9999');
    oJson.AddPair('sigla_uf'   , 'AA');
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

procedure TestTestProvatecCredores.TesteExcluir;
begin
  try
    FRESTClient1.BaseURL := 'http://localhost:9000/credordelete/' + IntToStr(13);
    FRESTRequest1.Method := rmDELETE;
    FRESTRequest1.Execute;

    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  finally
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecCredores.TestIncluir;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='credorinsert';
    FRESTRequest1.Method       := rmPOST;
    oJson := TJSONObject.Create;
    oJson.AddPair('cpfcnpj'    , '99999999999999');
    oJson.AddPair('nome'       , 'CREDOR DE TESTE');
    oJson.AddPair('cep'        , '9999999');
    oJson.AddPair('logradouro' , 'RUA TESTE');
    oJson.AddPair('numero'     , '99');
    oJson.AddPair('complemento', 'TESTE');
    oJson.AddPair('bairro'     , 'BAIRRO TESTE');
    oJson.AddPair('cidade'     , 'CIDADE TESTE');
    oJson.AddPair('ibge_cidade', '9999');
    oJson.AddPair('sigla_uf'   , 'AA');
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
  RegisterTest(TestTestProvatecCredores.Suite);

end.
