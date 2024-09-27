unit uCadFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Mask, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TfrmCadFormBase = class(TForm)
    pnl_Bottom: TPanel;
    pnl_Contato: TPanel;
    BTN_Inserir: TBitBtn;
    BTN_Editar: TBitBtn;
    BTN_Cancelar: TBitBtn;
    BTN_Excluir: TBitBtn;
    pnl_Cliente: TPanel;
    BTN_Fechar: TBitBtn;
    BTN_Gravar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTN_FecharClick(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure BTN_EditarClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure BTN_GravarClick(Sender: TObject);
    procedure BTN_ExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MKE_TelefoneEnter(Sender: TObject);
    procedure MKE_TelefoneExit(Sender: TObject);
  private
    { Private declarations }
    strStatusCli: string;
    procedure DesabilitaBotao(bInserir,bEditar,bCancelar,bGravar,bExcluir: boolean);
  public
    { Public declarations }
    glbValIDCliente, glbValNomeCliente, gblID: string;
  end;

var
  frmCadFormBase: TfrmCadFormBase;

implementation

{$R *.dfm}

procedure TfrmCadFormBase.BTN_CancelarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  strStatusCli :='';
end;

procedure TfrmCadFormBase.BTN_EditarClick(Sender: TObject);
begin
  strStatusCli :='dsEditando';
  DesabilitaBotao(False, False, True, True, False);
end;

procedure TfrmCadFormBase.BTN_ExcluirClick(Sender: TObject);
begin
  strStatusCli :='dsExcluindo';
  DesabilitaBotao(True, True, False, False, True);
  ShowMessage('Contato foi Excluido com exito.');
end;

procedure TfrmCadFormBase.BTN_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadFormBase.BTN_GravarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  strStatusCli :='';
  ShowMessage('Dados foram gravados com exito.');
end;

procedure TfrmCadFormBase.BTN_InserirClick(Sender: TObject);
begin
  strStatusCli :='dsInserindo';
  DesabilitaBotao(False, False, True, True, False);
end;

procedure TfrmCadFormBase.DesabilitaBotao(bInserir, bEditar, bCancelar, bGravar, bExcluir: boolean);
begin
  BTN_Inserir.Enabled  :=bInserir;
  BTN_Editar.Enabled   :=bEditar;
  BTN_Cancelar.Enabled :=bCancelar;
  BTN_Gravar.Enabled   :=bGravar;
  BTN_Excluir.Enabled  :=bExcluir;
end;

procedure TfrmCadFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmCadFormBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if key=vk_return then
     Perform(WM_nextdlgctl,0,0)
 else if Key=vk_escape then
     Perform(WM_nextdlgctl,1,0);
end;

procedure TfrmCadFormBase.FormShow(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
end;

procedure TfrmCadFormBase.MKE_TelefoneEnter(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clYellow;
end;

procedure TfrmCadFormBase.MKE_TelefoneExit(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clWindow;
end;

end.
