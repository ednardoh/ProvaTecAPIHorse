//-----------------------------------------------------------------------------
//Camada de Modelo das tabelas usada pelo CRUD, que no caso é a tabela
//de endereços no FireBird 2.5 "TB_ENDERECO"
//-----------------------------------------------------------------------------
unit Model.Endereco;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelEndereco = class
  private
    Fid         : integer;
    Fcep        : string;
    Flogradouro : string;
    Fcomplemento: string;
    Fbairro     : string;
    Fcidade     : string;
    Flocalidade : string;
    Fuf         : string;

    procedure Setid(const Value: integer);
    procedure Setcep(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setbairro(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setlocalidade(const Value: string);
    procedure Setuf(const Value: string);
  public
    property id:          integer read Fid          write Setid;
    property cep:         string  read Fcep         write Setcep;
    property logradouro:  string  read Flogradouro  write Setlogradouro;
    property complemento: string  read Fcomplemento write Setcomplemento;
    property bairro:      string  read Fbairro      write Setbairro;
    property cidade:      string  read Fcidade      write Setcidade;
    property localidade:  string  read Flocalidade  write Setlocalidade;
    property uf:          string  read Fuf          write Setuf;

end;

implementation

{ TModelCliente }

procedure TModelEndereco.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TModelEndereco.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TModelEndereco.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TModelEndereco.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TModelEndereco.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TModelEndereco.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TModelEndereco.Setlocalidade(const Value: string);
begin
  Flocalidade := Value;
end;

procedure TModelEndereco.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
