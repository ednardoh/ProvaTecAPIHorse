program ProvaTecnica;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDatamodulo in 'uDatamodulo.pas' {frmDatamodulo: TDataModule},
  UConecta in 'UConecta.pas',
  UConexaoBDpas in 'UConexaoBDpas.pas' {frmConectaDB},
  uCadEndereco in 'uCadEndereco.pas' {frmCadEnderecos},
  uCadFormBase in 'uCadFormBase.pas' {frmCadFormBase},
  superobject in 'Classes\superobject.pas',
  supertypes in 'Classes\supertypes.pas',
  superdate in 'Classes\superdate.pas',
  supertimezone in 'Classes\supertimezone.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDatamodulo, frmDatamodulo);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
