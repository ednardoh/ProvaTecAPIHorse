object frmDatamodulo: TfrmDatamodulo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 301
  Width = 409
  object dsPesquisa: TDataSource
    Left = 184
    Top = 24
  end
  object dsClientes: TDataSource
    Left = 274
    Top = 24
  end
  object dsContatos: TDataSource
    Left = 274
    Top = 84
  end
  object DBConect: TFDConnection
    Params.Strings = (
      'Database=db_provatecnica'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 32
    Top = 64
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\psqlODBC\1600\bin\libpq.dll'
    Left = 24
    Top = 8
  end
  object QryAux: TFDQuery
    Connection = DBConect
    Left = 104
    Top = 72
  end
end
