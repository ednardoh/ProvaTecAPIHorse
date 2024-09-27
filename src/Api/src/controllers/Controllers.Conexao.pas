unit Controllers.Conexao;

interface

uses
  uConexao, System.SysUtils;

type
  TControllersConexao = class
  private
    FConexao     : TConexao;

    class var FInstance: TControllersConexao;

  public
    constructor Create();
    destructor Destroy; override;

    class function GetInstance: TControllersConexao;

     property Conexao: TConexao read FConexao write FConexao;
  end;

implementation

{ TSistemaControl }

constructor TControllersConexao.Create();
begin
  FConexao := TConexao.Create;
end;

destructor TControllersConexao.Destroy;
begin
  FConexao.Free;

  inherited;
end;

class function TControllersConexao.GetInstance: TControllersConexao;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TControllersConexao.Create();
  end;

  Result := Self.FInstance;
end;

end.
