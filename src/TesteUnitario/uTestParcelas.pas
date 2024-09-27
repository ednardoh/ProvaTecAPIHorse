unit uTestParcelas;

interface
uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils,
  Vcl.Forms, DUnitX.TestFramework, REST.Response.Adapter,
  REST.Client, REST.Types, REST.Json, System.JSON;

type

  [TestFixture]
  TestTestProvatecParcelas = class(TTestCase)
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

{ TestTestProvatecParcelas }

procedure TestTestProvatecParcelas.SetUp;
begin
  FRESTClient1  := TRESTClient.Create(nil);
  FRESTRequest1 := TRESTRequest.Create(nil);
  FRESTResponse1:= TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  {SETUP}
  FRESTRequest1.Client:= FRESTClient1;
end;

procedure TestTestProvatecParcelas.TearDown;
begin
  FRESTClient1.Free;
  FRESTRequest1.Free;
  FRESTResponse1.Free;
  FRESTResponseDataSetAdapter.Free;
end;

procedure TestTestProvatecParcelas.TesteAlterar;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='parcelaupdate';
    FRESTRequest1.Method       := rmPUT;
    oJson := TJSONObject.Create;
    oJson.AddPair('id_parcelas'        , '15');
    oJson.AddPair('id_tipo_pgto'       , '1');
    oJson.AddPair('id_credor'          , '13');
    oJson.AddPair('id_cliente'         , '15');
    oJson.AddPair('valor_total'        , '180.2');
    oJson.AddPair('dt_primeira_parcela', '');
    oJson.AddPair('vl_primeira_parcela', '');
    oJson.AddPair('dt_segunda_parcela' , '');
    oJson.AddPair('vl_segunda_parcela' , '');
    oJson.AddPair('dt_terceira_parcela', '');
    oJson.AddPair('vl_terceira_parcela', '');
    oJson.AddPair('dt_quarta_parcela'  , '');
    oJson.AddPair('vl_quarta_parcela'  , '');
    oJson.AddPair('status'   , '2');
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

procedure TestTestProvatecParcelas.TesteExcluir;
begin
  try
    FRESTClient1.BaseURL := 'http://localhost:9000/parceladelete/' + IntToStr(15);
    FRESTRequest1.Method := rmDELETE;
    FRESTRequest1.Execute;
  finally
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecParcelas.TestIncluir;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     := 'parcelainsert';
    FRESTRequest1.Method       := rmPOST;
    oJson := TJSONObject.Create;
    oJson.AddPair('id_tipo_pgto'       , '1');
    oJson.AddPair('id_credor'          , '13');
    oJson.AddPair('id_cliente'         , '15');
    oJson.AddPair('valor_total'        , '120.2');
    oJson.AddPair('dt_primeira_parcela', '');
    oJson.AddPair('vl_primeira_parcela', '');
    oJson.AddPair('dt_segunda_parcela' , '');
    oJson.AddPair('vl_segunda_parcela' , '');
    oJson.AddPair('dt_terceira_parcela', '');
    oJson.AddPair('vl_terceira_parcela', '');
    oJson.AddPair('dt_quarta_parcela'  , '');
    oJson.AddPair('vl_quarta_parcela'  , '');
    oJson.AddPair('status'             , '2');  //0=Em aberto, 1=Em Atraso, 2=Liquidado
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
  RegisterTest(TestTestProvatecParcelas.Suite);

end.
