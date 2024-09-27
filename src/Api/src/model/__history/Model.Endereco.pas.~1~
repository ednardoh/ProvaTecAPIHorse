unit Model.Cliente;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelCliente = class
  private
    Fid         : integer;
    Fcpf        : string;
    Fnome       : string;
    Fcep        : string;
    Flogradouro : string;
    Fnumero     : string;
    Fcomplemento: string;
    Fbairro     : string;
    Fcidade     : string;
    Fibge_cidade: string;
    Fsigla_uf   : string;

    procedure Setid(const Value: integer);
    procedure Setcpf(const Value: string);
    procedure Setnome(const Value: string);
    procedure Setcep(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setnumero(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setbairro(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setibge_cidade(const Value: string);
    procedure Setsigla_uf(const Value: string);
  public
    property id:          integer read Fid          write Setid;
    property cpf:         string  read Fcpf         write Setcpf;
    property nome:        string  read Fnome        write Setnome;
    property cep:         string  read Fcep         write Setcep;
    property logradouro:  string  read Flogradouro  write Setlogradouro;
    property numero:      string  read Fnumero      write Setnumero;
    property complemento: string  read Fcomplemento write Setcomplemento;
    property bairro:      string  read Fbairro      write Setbairro;
    property cidade:      string  read Fcidade      write Setcidade;
    property ibge_cidade: string  read Fibge_cidade write Setibge_cidade;
    property sigla_uf:    string  read Fsigla_uf    write Setsigla_uf;

end;

implementation

{ TModelCliente }

procedure TModelCliente.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TModelCliente.Setcpf(const Value: string);
begin
  Fcpf := Value;
end;

procedure TModelCliente.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TModelCliente.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TModelCliente.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TModelCliente.Setnumero(const Value: string);
begin
  Fnumero := Value;
end;

procedure TModelCliente.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TModelCliente.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TModelCliente.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TModelCliente.Setibge_cidade(const Value: string);
begin
  Fibge_cidade := Value;
end;

procedure TModelCliente.Setsigla_uf(const Value: string);
begin
  Fsigla_uf := Value;
end;

end.
