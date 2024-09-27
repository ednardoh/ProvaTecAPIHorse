//-----------------------------------------------------------------------------
//Camada de Controle, que passa os dados para o Front-end
//-----------------------------------------------------------------------------
unit Controllers.Endereco;

interface

uses Horse, DataSet.Serialize, System.JSON, Data.DB,
     DAO.Endereco, System.SysUtils, Horse.GBSwagger.Register,
     Horse.GBSwagger.Controller, GBSwagger.Path.Attributes,
     Model.Endereco;

  procedure Registry;
  procedure ListById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ListByLogradouro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);



implementation

{ TEnderecoControllers }

//Busca o Endere�o por uma parte do Logradouro
procedure ListByLogradouro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
  sNome: string;
begin
  try
    LDAOEndereco := TEnderecoDAO.Create;
    sNome := Req.Params.Items['nome'];
    Res.Send<TJSONArray>(LDAOEndereco.ListByLogradouro(sNome));
  finally
    LDAOEndereco.Free;
  end;
end;

//Busca Endere�o pelo ID
procedure ListById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
  iId: Integer;
begin
  try
    LDAOEndereco := TEnderecoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    Res.Send<TJSONArray>(LDAOEndereco.ListById(iId));
  finally
    LDAOEndereco.Free;
  end;
end;

//Lista todos os Endere�os
procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
begin
  try
    LDAOEndereco := TEnderecoDAO.Create;
    Res.Send<TJSONArray>(LDAOEndereco.ListAll);
  finally
    LDAOEndereco.Free;
  end;
end;

//Insert
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
  oJson: TJSONObject;
  EnderecoModel: TModelEndereco;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Endere�o n�o encontrado.');
    LDAOEndereco := TEnderecoDAO.Create;
    EnderecoModel := TModelEndereco.Create;
    oJson := Req.Body<TJSONObject>;
    EnderecoModel.id          := 0; //GetId vai gerar autom�tico na DAO
    EnderecoModel.cep         := oJson.GetValue<string>('cep');
    EnderecoModel.logradouro  := oJson.GetValue<string>('logradouro');
    EnderecoModel.complemento := oJson.GetValue<string>('complemento');
    EnderecoModel.bairro      := oJson.GetValue<string>('bairro');
    EnderecoModel.cidade      := oJson.GetValue<string>('cidade');
    EnderecoModel.localidade  := oJson.GetValue<string>('localidade');
    EnderecoModel.uf          := oJson.GetValue<string>('uf');
    LDAOEndereco.Insert(EnderecoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.Created);
  finally
    LDAOEndereco.Free;
    EnderecoModel.Free;
  end;
end;

//Update
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
  oJson: TJSONObject;
  EnderecoModel: TModelEndereco;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Endere�o n�o encontrado.');
    LDAOEndereco := TEnderecoDAO.Create;
    EnderecoModel := TModelEndereco.Create;
    oJson := Req.Body<TJSONObject>;
    EnderecoModel.id          := oJson.GetValue<Integer>('id');
    EnderecoModel.cep         := oJson.GetValue<string>('cep');
    EnderecoModel.logradouro  := oJson.GetValue<string>('logradouro');
    EnderecoModel.complemento := oJson.GetValue<string>('complemento');
    EnderecoModel.bairro      := oJson.GetValue<string>('bairro');
    EnderecoModel.cidade      := oJson.GetValue<string>('cidade');
    EnderecoModel.localidade  := oJson.GetValue<string>('localidade');
    EnderecoModel.uf          := oJson.GetValue<string>('uf');
    LDAOEndereco.Update(EnderecoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.OK);
  finally
    LDAOEndereco.Free;
    EnderecoModel.Free;
  end;
end;

//Delete
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOEndereco: TEnderecoDAO;
  iId: Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id n�o encontrado.');
  try
    LDAOEndereco := TEnderecoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    LDAOEndereco.Delete(iId);
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message', 'Endere�o deletado com sucesso.'));
  finally
    LDAOEndereco.Free;
  end;
end;

//Registra as rotas
procedure Registry;
begin
  THorse.Group.Prefix('v1')
  .Get('/endereco/:nome'   , ListByLogradouro)
  .Get('/enderecobyid/:id' , ListById)
  .Get('/endereco'         , ListAll)
  .Post('/endereco'        , Insert)
  .Put('/endereco'         , Update)
  .Delete('/endereco/:id'  , Delete);
end;

end.


