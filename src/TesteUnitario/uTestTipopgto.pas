unit uTestTipopgto;

interface
uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils,
  Vcl.Forms, DUnitX.TestFramework, REST.Response.Adapter,
  REST.Client, REST.Types, REST.Json, System.JSON;

type

  [TestFixture]
  TestTestProvatecTipopgto = class(TTestCase)
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

{ TestTestProvatecCliente }

procedure TestTestProvatecTipopgto.SetUp;
begin
  FRESTClient1  := TRESTClient.Create(nil);
  FRESTRequest1 := TRESTRequest.Create(nil);
  FRESTResponse1:= TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  {SETUP}
  FRESTRequest1.Client:= FRESTClient1;
end;

procedure TestTestProvatecTipopgto.TearDown;
begin
  FRESTClient1.Free;
  FRESTRequest1.Free;
  FRESTResponse1.Free;
  FRESTResponseDataSetAdapter.Free;
end;

procedure TestTestProvatecTipopgto.TesteAlterar;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     := 'tipopgtoupdate';
    FRESTRequest1.Method       := rmPUT;
    oJson := TJSONObject.Create;
    oJson.AddPair('id'         , TJSONNumber.Create(9));
    oJson.AddPair('tipopgto'   , 'A VISTA TESTE ALTERADO');
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

procedure TestTestProvatecTipopgto.TesteExcluir;
begin
  try
    FRESTClient1.BaseURL := 'http://localhost:9000/tipopgtodelete/' + IntToStr(9);
    FRESTRequest1.Method := rmDELETE;
    FRESTRequest1.Execute;
  finally
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecTipopgto.TestIncluir;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     := 'tipopgtoinsert';
    FRESTRequest1.Method       := rmPOST;
    oJson := TJSONObject.Create;
    oJson.AddPair('tipopgto' , 'A VISTA TESTE');
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
  RegisterTest(TestTestProvatecTipopgto.Suite);

end.
