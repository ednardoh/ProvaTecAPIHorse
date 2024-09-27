unit uCadEndereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons, uDatamodulo, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, System.Net.HttpClient,
  REST.Types, System.Types, System.StrUtils, System.ImageList, Vcl.ImgList,
  Vcl.Imaging.pngimage, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Json, Vcl.ComCtrls, Winapi.TlHelp32,
  ShellApi, dxGDIPlusClasses;

type
  TfrmCadEnderecos = class(TForm)
    pnl_Cadcli: TPanel;
    pnl_Client: TPanel;
    EDT_Localidade: TEdit;
    Label1: TLabel;
    MKE_CEP: TMaskEdit;
    Btn_Cep: TButton;
    Label2: TLabel;
    Label3: TLabel;
    EDT_Logradouro: TEdit;
    EDT_Complemento: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EDT_Cidade: TEdit;
    Label8: TLabel;
    EDT_Uf: TEdit;
    pnl_Botoes: TPanel;
    BTN_Inserir: TBitBtn;
    BTN_Editar: TBitBtn;
    BTN_Gravar: TBitBtn;
    BTN_Excluir: TBitBtn;
    BTN_Cancelar: TBitBtn;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    Label10: TLabel;
    EDT_Bairro: TEdit;
    imgHorse: TImage;
    EDT_Pesquisaend: TEdit;
    BTN_Webapi: TBitBtn;
    Label11: TLabel;
    ds_Enderecos: TDataSource;
    TBEnderecos: TFDMemTable;
    TBEnderecosid: TIntegerField;
    TBEnderecosCep: TWideStringField;
    TBEnderecosLogradouro: TWideStringField;
    TBEnderecosBairro: TWideStringField;
    TBEnderecosCidade: TWideStringField;
    TBEnderecosuf: TWideStringField;
    TBEnderecosComplemento: TWideStringField;
    TBEnderecosLocalidade: TWideStringField;
    PGC_Clientes: TPageControl;
    TBS_Grdcliente: TTabSheet;
    DBG_CadCli: TDBGrid;
    pn_Top: TPanel;
    img_Top: TImage;
    pn_Bottom: TPanel;
    img_Bottom: TImage;
    cbo_Api: TComboBox;
    Label13: TLabel;
    EDT_id: TEdit;
    Label14: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure BTN_EditarClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure BTN_GravarClick(Sender: TObject);
    procedure BTN_ExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EDT_LocalidadeEnter(Sender: TObject);
    procedure EDT_LocalidadeExit(Sender: TObject);
    procedure MKE_CEPEnter(Sender: TObject);
    procedure MKE_CEPExit(Sender: TObject);
    procedure DBG_CadCliDblClick(Sender: TObject);
    procedure DBG_CadCliCellClick(Column: TColumn);
    procedure Btn_CepClick(Sender: TObject);
    procedure BTN_WebapiClick(Sender: TObject);
  private
    { Private declarations }
    strStatusEnd: string;
    IntID: Integer;
    Objeto,
    Objt: TJsonObject;
    ParRows,
    PRows: TJsonPair;
    function FormatJson (InString: WideString): string;
    function ProcessExists(exeFileName: string): Boolean;
    function IsNumber(strVal: string): boolean;
    procedure DesabilitaBotao(bInserir,bEditar,bCancelar,bGravar,bExcluir: boolean);
    procedure LimpaCampos;
    procedure PreencheCampos;
    procedure GravaEndereco;
    procedure ExcluiDados;
    procedure LeRegistros;
    procedure AtualizaCliente;
    procedure BuscaCep(strURL, strAText: string); //busca Cep
    procedure BuscaEndereco(strURL, strAText: string); //busca Enderecos
    procedure PreencheDataSetEnderecos(strJSONValue: string);
  public
    { Public declarations }
  end;

var
  frmCadEnderecos: TfrmCadEnderecos;

implementation

{$R *.dfm}

uses superobject, supertypes, superdate;

procedure TfrmCadEnderecos.AtualizaCliente;
begin
  DesabilitaBotao(True, True, False, False, True);
end;

procedure TfrmCadEnderecos.BTN_CancelarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  strStatusEnd :='';
end;

procedure TfrmCadEnderecos.Btn_CepClick(Sender: TObject);
begin
  case cbo_Api.ItemIndex of
    0:BuscaCep('https://viacep.com.br/ws/'+trim(MKE_CEP.Text)+'/json/','');
    1:BuscaCep('https://cdn.apicep.com/file/apicep/'+trim(MKE_CEP.Text)+'.json','');
    2:BuscaCep('https://cep.awesomeapi.com.br/json/'+trim(MKE_CEP.Text),'');
  end;
end;

procedure TfrmCadEnderecos.BTN_EditarClick(Sender: TObject);
begin
  strStatusEnd :='dsEditando';
  DesabilitaBotao(False, False, True, True, False);
  cbo_Api.SetFocus;
end;

procedure TfrmCadEnderecos.BTN_ExcluirClick(Sender: TObject);
begin
  strStatusEnd :='dsExcluindo';
  DesabilitaBotao(True, True, False, False, True);
  ExcluiDados;
  LeRegistros;
end;

procedure TfrmCadEnderecos.BTN_GravarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  GravaEndereco;
  strStatusEnd :='';
  ShowMessage('Dados foram gravados com exito.');
  LeRegistros;
end;

procedure TfrmCadEnderecos.BTN_InserirClick(Sender: TObject);
begin
  strStatusEnd :='dsInserindo';
  DesabilitaBotao(False, False, True, True, False);
  LimpaCampos;
  cbo_Api.SetFocus;
end;

procedure TfrmCadEnderecos.BTN_WebapiClick(Sender: TObject);
begin
  if EDT_Pesquisaend.Text = '' then
    BuscaEndereco('http://localhost:9000/v1/endereco','')
  else
    if IsNumber(Trim(EDT_Pesquisaend.Text)) then
      BuscaEndereco('http://localhost:9000/v1/enderecobyid/',trim(EDT_Pesquisaend.Text))
  else
    BuscaEndereco('http://localhost:9000/v1/endereco/',EDT_Pesquisaend.Text);
end;

procedure TfrmCadEnderecos.BuscaCep(strURL, strAText: string);
begin
  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  Objeto  := RESTResponse1.JSONValue as TJSONObject;

  case cbo_Api.ItemIndex of
    0:begin
        //Logradouro
        ParRows := Objeto.Get('logradouro');
        EDT_Logradouro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Complemento
        ParRows := Objeto.Get('complemento');
        EDT_Complemento.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Bairro
        ParRows := Objeto.Get('bairro');
        EDT_Bairro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Cidade
        ParRows := Objeto.Get('localidade');
        EDT_Cidade.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Localidade
        ParRows := Objeto.Get('localidade');
        EDT_Localidade.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Estado
        ParRows := Objeto.Get('uf');
        EDT_Uf.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

      end;
    1:begin
        //Logradouro
        ParRows := Objeto.Get('address');
        EDT_Logradouro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Complemento
        EDT_Complemento.Text :='';

        //Bairro
        ParRows := Objeto.Get('district');
        EDT_Bairro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Cidade
        ParRows := Objeto.Get('city');
        EDT_Cidade.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Localidade
        EDT_Localidade.Text :='';

        //Estado
        ParRows := Objeto.Get('state');
        EDT_Uf.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

      end;
    2:begin
        //Logradouro
        ParRows := Objeto.Get('address');
        EDT_Logradouro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Complemento
        EDT_Complemento.Text :='';

        //Bairro
        ParRows := Objeto.Get('district');
        EDT_Bairro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Cidade
        ParRows := Objeto.Get('city');
        EDT_Cidade.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

        //Localidade
        EDT_Localidade.Text :='';

        //Estado
        ParRows := Objeto.Get('state');
        EDT_Uf.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

      end;
  end;
end;

procedure TfrmCadEnderecos.BuscaEndereco(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  TBEnderecos.Close;
  TBEnderecos.Open;
  TBEnderecos.EmptyDataSet;
  TBEnderecos.IndexFieldNames := 'id';   //s� para order por id
  DBG_CadCli.DataSource := Nil;
  DBG_CadCli.DataSource := ds_Enderecos;
  TBEnderecos.Close;
  TBEnderecos.Open;

  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode in [200,201,204] then
    begin
      PreencheDataSetEnderecos(RESTResponse1.Content);  //processa o JSon
    end;
end;

procedure TfrmCadEnderecos.DBG_CadCliCellClick(Column: TColumn);
begin
  PreencheCampos;
end;

procedure TfrmCadEnderecos.DBG_CadCliDblClick(Sender: TObject);
begin
  PreencheCampos;
end;

procedure TfrmCadEnderecos.DesabilitaBotao(bInserir, bEditar, bCancelar, bGravar, bExcluir: boolean);
begin
  BTN_Inserir.Enabled  :=bInserir;
  BTN_Editar.Enabled   :=bEditar;
  BTN_Cancelar.Enabled :=bCancelar;
  BTN_Gravar.Enabled   :=bGravar;
  BTN_Excluir.Enabled  :=bExcluir;
end;

procedure TfrmCadEnderecos.EDT_LocalidadeEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
end;

procedure TfrmCadEnderecos.EDT_LocalidadeExit(Sender: TObject);
begin
  TEdit(Sender).Color := clWindow;
end;

procedure TfrmCadEnderecos.ExcluiDados;
begin
  if strStatusEnd ='dsExcluindo' then
    begin
      if Application.messageBox('Deseja Realmente Apagar Esse Endere�o?',
        'Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
        begin
          try
            Showmessage('Aten��o! Os Endere�o ser�o excluidos.');
            RESTClient1.BaseURL := 'http://localhost:9000/v1/endereco/' + IntToStr(IntID);
            RESTRequest1.Method := rmDELETE;
            RESTRequest1.Execute;

            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          finally
            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          end;
        end;
    end;
end;

function TfrmCadEnderecos.FormatJson(InString: WideString): string;
var
  Json : ISuperObject;
begin
  Json := TSuperObject.ParseString(PWideChar(InString), True);
  Result := Json.AsJson(true, false);
end;

procedure TfrmCadEnderecos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmCadEnderecos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
     Perform(WM_nextdlgctl,0,0)
  else if Key=vk_escape then
     Perform(WM_nextdlgctl,1,0);
end;

procedure TfrmCadEnderecos.FormShow(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  DBG_CadCli.DataSource := Nil;
  DBG_CadCli.DataSource := ds_Enderecos;
  TBEnderecos.Open;
  TBEnderecos.Open;
  if not ProcessExists('ApiHorse.exe') then
    ShellExecute(handle,'open',PChar(ExtractFilepath(Application.ExeName)+'ApiHorse.exe'), '','',SW_SHOWMINIMIZED);
end;

procedure TfrmCadEnderecos.GravaEndereco;
var
  oJson: TJSONObject;
begin
  if strStatusEnd ='dsInserindo' then
    begin
      try
        RESTClient1.BaseURL       := 'http://localhost:9000/v1/';
        RESTRequest1.Resource     :='endereco';
        RESTRequest1.Method       := rmPOST;
        oJson := TJSONObject.Create;
        oJson.AddPair('cep'        , MKE_CEP.Text);
        oJson.AddPair('logradouro' , EDT_Logradouro.Text);
        oJson.AddPair('complemento', EDT_Complemento.Text);
        oJson.AddPair('bairro'     , EDT_Bairro.Text);
        oJson.AddPair('cidade'     , EDT_Cidade.Text);
        oJson.AddPair('localidade' , EDT_Localidade.Text);
        oJson.AddPair('uf'         , EDT_Uf.Text);
        RESTRequest1.AddBody(oJson);
        RESTRequest1.Execute;
      finally
        oJson.Free;
        RESTClient1.BaseURL   :='';
        RESTRequest1.Resource :='';
        RESTRequest1.Method   := rmGET;
        RESTRequest1.AddBody('');
      end;
    end
  else
    if strStatusEnd ='dsEditando' then
      begin
        try
          RESTClient1.BaseURL       := 'http://localhost:9000/v1/';
          RESTRequest1.Resource     :='endereco';
          RESTRequest1.Method       := rmPUT;
          oJson := TJSONObject.Create;
          oJson.AddPair('id'         , TJSONNumber.Create(IntID));
          oJson.AddPair('cep'        , MKE_CEP.Text);
          oJson.AddPair('logradouro' , EDT_Logradouro.Text);
          oJson.AddPair('complemento', EDT_Complemento.Text);
          oJson.AddPair('bairro'     , EDT_Bairro.Text);
          oJson.AddPair('cidade'     , EDT_Cidade.Text);
          oJson.AddPair('localidade' , EDT_Localidade.Text);
          oJson.AddPair('uf'         , EDT_Uf.Text);
          RESTRequest1.AddBody(oJson);
          RESTRequest1.Execute;
        finally
          oJson.Free;
          RESTClient1.BaseURL   :='';
          RESTRequest1.Resource :='';
          RESTRequest1.Method   := rmGET;
          RESTRequest1.AddBody('');
        end;
      end;
  strStatusEnd :='';
end;

function TfrmCadEnderecos.IsNumber(strVal: string): boolean;
begin
  if StrToIntDef(strVal, 0) = 0 then
    Result := False
  else
    Result := True;
end;

procedure TfrmCadEnderecos.LeRegistros;
begin
  Refresh;
  BTN_WebapiClick(Self);
end;

procedure TfrmCadEnderecos.LimpaCampos;
begin
  EDT_id.Text := '0';
  MKE_CEP.Clear;
  EDT_Logradouro.Clear;
  EDT_Complemento.Clear;
  EDT_Bairro.Clear;
  EDT_Cidade.Clear;
  EDT_Localidade.Clear;
  EDT_Uf.Clear;
end;

procedure TfrmCadEnderecos.MKE_CEPEnter(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clYellow;
end;

procedure TfrmCadEnderecos.MKE_CEPExit(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clWindow;
end;

procedure TfrmCadEnderecos.PreencheCampos;
begin
  IntID                := ds_Enderecos.DataSet.FieldByName('id').AsInteger;
  EDT_id.Text          := IntID.ToString;
  MKE_CEP.Text         := ds_Enderecos.DataSet.FieldByName('cep').AsString;
  EDT_Logradouro.Text  := ds_Enderecos.DataSet.FieldByName('logradouro').AsString;
  EDT_Complemento.Text := ds_Enderecos.DataSet.FieldByName('complemento').AsString;
  EDT_Bairro.Text      := ds_Enderecos.DataSet.FieldByName('bairro').AsString;
  EDT_Cidade.Text      := ds_Enderecos.DataSet.FieldByName('cidade').AsString;
  EDT_Localidade.Text  := ds_Enderecos.DataSet.FieldByName('localidade').AsString;
  EDT_Uf.Text          := ds_Enderecos.DataSet.FieldByName('uf').AsString;
end;

procedure TfrmCadEnderecos.PreencheDataSetEnderecos(strJSONValue: string);
var
  JsonObjArray: TJSONArray;
  JsonObjectJson: TJSONObject;
  strTOJSon: string;
  I: Integer;
begin
  //Processa o JSon para DataSet - Horse
  Application.ProcessMessages;

  JsonObjArray := TJSONObject.ParseJSONValue( strJSONValue ) as TJSONArray;

  for I := 0 to JsonObjArray.Count-1 do
    begin
      strTOJSon := JsonObjArray.Items[I].ToJSON;
      JsonObjectJson := TJSONObject.ParseJSONValue( strTOJSon ) as TJSONObject;

      TBEnderecos.Insert;
      TBEnderecosid.AsString          := JsonObjectJson.GetValue('id').Value;
      TBEnderecosCep.AsString         := JsonObjectJson.GetValue('cep').Value;
      TBEnderecosLogradouro.AsString  := JsonObjectJson.GetValue('logradouro').Value;
      TBEnderecosComplemento.AsString := JsonObjectJson.GetValue('complemento').Value;
      TBEnderecosBairro.AsString      := JsonObjectJson.GetValue('bairro').Value;
      TBEnderecosCidade.AsString      := JsonObjectJson.GetValue('cidade').Value;
      TBEnderecosLocalidade.AsString  := JsonObjectJson.GetValue('localidade').Value;
      TBEnderecosuf.AsString          := JsonObjectJson.GetValue('uf').Value;
      TBEnderecos.Post;
    end;
end;

function TfrmCadEnderecos.ProcessExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

end.
