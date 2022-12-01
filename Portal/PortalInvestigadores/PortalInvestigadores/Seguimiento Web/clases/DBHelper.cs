using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Net;
using System.Collections.Specialized;

namespace Portal_Investigadores.clases
{
    public class DBHelper
    {
        string connStr = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
        public static int auxAdmin;
        public static int auxUsuario;

        public DBHelper()
        {

        }

        #region Usuarios

        public int verifyUser(string usuario, string password, string clientIp)
        {
         
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_ValidarUsuarioPortal", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                        cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                        cmd.Parameters.Add("@ip", SqlDbType.VarChar).Value = clientIp;
                        con.Open();
                        int resp = int.Parse(cmd.ExecuteScalar().ToString());

                        if (resp == 1)
                        {
                            return 1;
                        }
                        else if (resp == 2)
                        {
                            return 2;
                        }
                        else {
                            return 0;
                        }
                    }
                }
            }
            catch
            {
                throw;
            }


            //try
            //{
            //    using (SqlConnection con = new SqlConnection(connStr))
            //    {

            //        List<string> usuarios = new List<string>();
            //        String query = "SELECT usuario, contrasena FROM CatalogoUsuarioPortal WHERE usuario = '" + usuario + "' and contrasena = '" + password+"' and activo = 1";
            //        SqlCommand cmd = new SqlCommand(query, con);
            //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //        DataTable dt = new DataTable("Usuario");
            //        sda.Fill(dt);
            //        if (dt.Rows.Count == 1)
            //        {
            //            //string correctPassword = Decrypt(dt.Rows[0][1].ToString().Trim(), EncryptionKey);
            //            //string correctPassword = Decrypt(Encrypted, EncryptionKey);
            //            //if (correctPassword == password)
            //                return true;
            //            //else {
            //              //  return false;
            //           // }
            //        }
            //        else
            //        {
            //            return false;

            //        }
            //    }
            //}
            //catch
            //{
            //    throw;
            //}
        }

        public bool verifyUserExist(string correo)
        {
            //string EncryptionKey = GenerateEncryptionKey();

            //string Encrypted = Encrypt(password, EncryptionKey);
            //string Decrypted = Decrypt(Encrypted, EncryptionKey);

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT correo FROM PR_CatalogoUsuarioPortal WHERE correo = '" + correo + "' and activo = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    if (dt.Rows.Count == 1)
                    {
                        //string correctPassword = Decrypt(dt.Rows[0][1].ToString().Trim(), EncryptionKey);
                        //string correctPassword = Decrypt(Encrypted, EncryptionKey);
                        //if (correctPassword == password)
                        return true;
                        //else {
                        //  return false;
                        // }
                    }
                    else
                    {
                        return false;

                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public int getPerfil(string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT Perfil FROM PR_Investigadores WHERE usuario = '" + usuario + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return int.Parse(dt.Rows[0][0].ToString());
                }
            }
            catch
            {
                throw;
            }
        }

        public string getUserName(string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT idUsuario, nombre, esInvestigador, esDelegado, esRevisor, esEnterado FROM PR_CatalogoUsuarioPortal WHERE usuario = '" + usuario + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return dt.Rows[0][0].ToString();
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getUserInfo(string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    List<string> usuarios = new List<string>();
                    String query = "SELECT idUsuario, nombre, tipoUsuario, esInvestigador, esDelegado, esRevisor, esEnterado, contrasenaTemporal, case when AdministradorDenuncias = null then 0 else AdministradorDenuncias end as AdministradorDenuncias  FROM PR_CatalogoUsuarioPortal WHERE usuario = '" + usuario + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getUserInfoBuzon(string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT idUsuario, nombre FROM PR_CatalogoUsuarioPortal WHERE usuario = '" + usuario + "' and TipoUsuario in (1,3,4) ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("UsuarioBuzon");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public bool recuperarContrasena(string correo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_RecuperarContrasenaResp", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@correo", SqlDbType.VarChar).Value = correo;
                        con.Open();
                        cmd.ExecuteNonQuery();

                        return true;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string retrieveUsername(string user)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT usuario FROM PR_CatalogoInvestigadores WHERE usuarioDominio = '" + user + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return dt.Rows[0][0].ToString();
                }
            }
            catch
            {
                throw;
            }
        }

        public string retrieveNombre(string user)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT nombre FROM PR_CatalogoUsuarios WHERE usuarioDominio = '" + user + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return dt.Rows[0][0].ToString();
                }
            }
            catch
            {
                throw;
            }
        }

        public int retrieveUserId(string user)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT idUsuario FROM PR_CatalogoUsuarios WHERE usuarioDominio = '" + user + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    return int.Parse(dt.Rows[0][0].ToString());
                }
            }
            catch
            {
                throw;
            }
        }

        public bool verifyUserEnv(string user)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT usuarioDominio FROM PR_CatalogoUsuarios WHERE usuarioDominio = '" + user + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Usuario");
                    sda.Fill(dt);
                    if (dt.Rows.Count == 1)
                    {
                        return true;
                    }
                    else
                    {
                        return false;

                    }
                }
            }
            catch
            {
                throw;
            }
        }

        #endregion

        public int changePassword(string usuario, string passwordAnt, string nuevaPassword)
        {
            string ip = GetIPAddress();
            
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_ChangePasswordPortal", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                        cmd.Parameters.Add("@passwordAnt", SqlDbType.VarChar).Value = passwordAnt;
                        cmd.Parameters.Add("@passwordNueva", SqlDbType.VarChar).Value = nuevaPassword;
                        cmd.Parameters.Add("@ip", SqlDbType.VarChar).Value = ip;
                        con.Open();
                        int resp = int.Parse(cmd.ExecuteScalar().ToString());

                        if (resp == 1)
                        {
                            return 1;
                        }
                        else
                        {
                            return 0;
                        }
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        #region Tags

        public DataTable getTags(int pagina, int idIdioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string idioma = "";

                    switch (idIdioma)
                    {
                        case 1:
                            idioma = "español";
                            break;
                        case 2:
                            idioma = "ingles";
                            break;
                    }

                    String query = "select id, case when "+ idioma + " IS NULL THEN español else " + idioma + " end as tag from PR_CatalogoEtiquetas where idPagina = " + pagina;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("tags");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }

        }

        #endregion

        public int getAcceso(int idDenuncia, int idUsuario) {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Acceso", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();

                        Int32 result = 0;

                        if (reader.Read())
                        {
                            result = (int)reader[0];

                        }

                        return result;

                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public int getAccesoCerradas(int idDenuncia, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_AccesoCerradas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();

                        Int32 result = 0;

                        if (reader.Read())
                        {
                            result = (int)reader[0];

                        }

                        return result;

                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadEquipo(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_get_DenunciasEquipo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadAsignadas(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasAsignadas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadPendAceptar(int idioma, string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_PendAceptar", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadDelegadas(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasDelegadas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadPendVoBo(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasPendVoBo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadCerradas(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasCerradas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadDenunciados(int id, int tipo, string grupo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Denunciados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadAllDenuncias(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_ALLDenuncias", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadRevAuditoria(int idioma, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasRevAuditoria", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadInvInvestigacion(int idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_InvInvestigacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                       
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadResponsables(int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Responsables", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable loadResponsablesFiltro(string grupo, string empresa)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_ResponsablesFiltro", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        con.Open();

                        DataTable dt = new DataTable();
                        dt.Load(cmd.ExecuteReader());
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getInfoDenuncia(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_infoDenuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenuncia(Int64 idDenuncia,int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Denuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDetalleAntecendes(Int64 idDenuncia, int tipo,  int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_get_DetalleAntecedente", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getUsuario(Int64 idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Usuario", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenunciaAsociada(Int64 idDenuncia, int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciaAsociada", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenuncias(int idResponsable, int tipoAsignacion)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Denuncias", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@tipoAsignacion", SqlDbType.Int).Value = tipoAsignacion;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenunciasPorId(int idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciaPorId", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDelegados(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Delegados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getResultados(int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string tagIdioma = "";
                    List<string> usuarios = new List<string>();
                    if (idioma == 1)
                    {
                        tagIdioma = "nombre";
                    }
                    else {
                        tagIdioma = "ingles as nombre";
                    }
                    String query = "SELECT idResultado, "+tagIdioma+" FROM PR_CatalogoResultados Where activo = 1 order by nombre desc";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Resultados");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getBeneficios(int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string tagIdioma = "";
                    List<string> usuarios = new List<string>();
                    if (idioma == 1)
                    {
                        tagIdioma = "nombre";
                    }
                    else
                    {
                        tagIdioma = "ingles as nombre";
                    }
                    String query = "SELECT idBeneficio, "+ tagIdioma + " FROM CatalogoBeneficios Where activo = 1 and idBeneficio not in (1,2,3,4,5,6,7) order by nombre";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Beneficios");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getGrupos()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(Grupo)) as Grupo, rtrim(ltrim(Descripcion)) as Descripcion FROM Grupos";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Grupos");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getEmpresas(string grupo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(Empresa)) as Empresa, rtrim(ltrim(Descripcion)) as Descripcion FROM Empresas where grupo = '"+grupo+"'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Empresas");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getEmpresasPermUsuario(string idusuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(Empresa)) as Empresa, rtrim(ltrim(Descripcion)) as Descripcion FROM PR_ConfAdminDen A inner join Empresas B ON A.tipo = 1 and A.Activo = 1 and A.valor = B.Empresa where idUsuario = " + idusuario + "";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Empresas");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getSitios(string grupo, string empresa)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(Sitio)) as Sitio, rtrim(ltrim(Descripcion)) as Descripcion FROM Sitios where grupo = '" + grupo + "' and empresa = '"+empresa+ "' order by Descripcion ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Sitios");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getSitiosAdmDen(string idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_SitiosEmpresa", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = int.Parse(idUsuario);

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getSitiosPermUsuario(string idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(Sitio)) as Sitio, rtrim(ltrim(Descripcion)) as Descripcion FROM Sitios A INNER JOIN PR_ConfAdminDen B on A.Sitio = B.valor and B.tipo = 2 and B.Activo = 1 and B.idUsuario = "+idUsuario+ " order by Descripcion "; 
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Sitios");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getAreasAdmDen(string idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim([ClasificacionT])) as ClasificacionT,rtrim(ltrim([Descripcion])) as Descripcion FROM [ClasificacionTarea] order by Descripcion ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Areas");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getAreasPermUsuario(string idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(ClasificacionT)) as ClasificacionT, rtrim(ltrim(Descripcion)) as Descripcion FROM ClasificacionTarea A INNER JOIN PR_ConfAdminDen B on A.ClasificacionT = B.valor and B.tipo = 3 and B.Activo = 1 and B.idUsuario = " + idUsuario + " order by Descripcion ";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Areas");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }


        public DataTable getDepartamentos(string grupo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT rtrim(ltrim(idDepartamento)) as Departamento, rtrim(ltrim(descDepartamento)) as Descripcion FROM Departamentos where idGrupo = '" + grupo + "' order by descDepartamento";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Departamentos");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDelegadosCatalogo(string grupo,string empresa, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DelegadosCatalogo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getRevisados(string grupo, string empresa, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Revisados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getEnterados(string grupo, string empresa, int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Enterados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDelegadosAsignados(int idResponsable)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DelegadosAsignados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getRevisadosAsignados(int idResponsable)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_RevisadosAsignados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getEnteradosAsignados(int idResponsable)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_EnteradosAsignados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string agregarDelegado(int idResponsable, int idDelegado, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_AgregarDelegado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idDelegado", SqlDbType.Int).Value = idDelegado;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.VarChar).Value = usuarioAlta;
                       
                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string agregarRevisado(int idResponsable, int idRevisado, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_AgregarRevisado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idRevisado", SqlDbType.Int).Value = idRevisado;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.VarChar).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string agregarEnterado(int idResponsable, int idEnterado, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_AgregarEnterado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idEnterado", SqlDbType.Int).Value = idEnterado;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.VarChar).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public int delegarDenuncia(Int64 idDenuncia, Int64 delegado, Int64 usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Delegar_Denuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@delegado", SqlDbType.Int).Value = delegado;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();

                        cmd.ExecuteReader();

                        return 1;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public int aceptarDenuncia(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Aceptar_Denuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                     
                        con.Open();

                        cmd.ExecuteReader();

                        return 1;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public int rechazarDenuncia(Int64 idDenuncia, string comentario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Rechazar_Denuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = comentario;

                        con.Open();

                        cmd.ExecuteReader();

                        return 1;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getInvDenuncia(Int64 idDenuncia, int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_InvDenuncia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getInvInvestigacion(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_InvInvestigacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                     

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getInvInvestigacionDetalle(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_InvInvestigacionDetalle", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;


                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getInvInvestigacionLite(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_InvInvestigacionLite", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;


                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenunciasAsociadas(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasAsociadas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenunciasAntecedentes(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenunciasAntecedentes", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDenAnt(Int64 idDenuncia, int tipo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DenAnt", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDocumentos(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_Documentos", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getDocumentosAntecedentes(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_Get_DocumentosAnte", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getAcciones(int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string tagIdioma = "";
                    List<string> usuarios = new List<string>();
                    if (idioma == 1)
                    {
                        tagIdioma = "nombre";
                    }
                    else
                    {
                        tagIdioma = "ingles as nombre";
                    }
                    String query = "SELECT idAccion, "+tagIdioma +" FROM CatalogoAcciones Where activo = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Accion");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getTipos(int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string tagIdioma = "";
                    List<string> usuarios = new List<string>();
                    if (idioma == 1)
                    {
                        tagIdioma = "nombre";
                    }
                    else
                    {
                        tagIdioma = "ingles as nombre";
                    }
                    String query = "SELECT id, "+tagIdioma+" FROM CatalogoTipo where estatus = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("Tipo");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getComentarios(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GetComentariosInvestigacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getEntrevistados(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GetEntrevistados", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string saveEntrevistado(int idDenuncia, int idEntrevistado, string nombre, string puesto, string entrevistador,int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarEntrevistado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idEntrevistado", SqlDbType.Int).Value = idEntrevistado;
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombre;
                        cmd.Parameters.Add("@puesto", SqlDbType.VarChar).Value = puesto;
                        cmd.Parameters.Add("@entrevistador", SqlDbType.VarChar).Value = entrevistador;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteEntrevistado(int idEntrevistado, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteEntrevistado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idEntrevistado", SqlDbType.Int).Value = idEntrevistado;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteDelegado(int idResponsable, int idDelegado, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteDelegado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idDelegado", SqlDbType.Int).Value = idDelegado;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteRevisado(int idResponsable, int idRevisado, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteRevisado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idRevisado", SqlDbType.Int).Value = idRevisado;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteEnterado(int idResponsable, int idEnterado, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteEnterado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        cmd.Parameters.Add("@idEnterado", SqlDbType.Int).Value = idEnterado;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteInvolucrado(int idInvolucrado, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteInvolucrado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idInvolucrado", SqlDbType.Int).Value = idInvolucrado;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteAdminDen(int idResponsable)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteAdminDen", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idResponsable", SqlDbType.Int).Value = idResponsable;
                        
                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string saveInvolucrado(int idDenuncia, int idInvolucrado, string nombre, string puesto, int tipo, string fechaIngreso, int acciones, string fechaCompromiso, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarInvolucrado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idInvolucrado", SqlDbType.Int).Value = idInvolucrado;
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombre;
                        cmd.Parameters.Add("@puesto", SqlDbType.VarChar).Value = puesto;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@fechaIngreso", SqlDbType.VarChar).Value = fechaIngreso;
                        cmd.Parameters.Add("@acciones", SqlDbType.Int).Value = acciones;
                        cmd.Parameters.Add("@fechaCompromiso", SqlDbType.VarChar).Value = fechaCompromiso;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public DataTable getTemas(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_getTemas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getTemasDetallado(Int64 idDenuncia)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_getTemasDetallado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getTemasLite(Int64 idDenuncia, int idioma)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GetTemasLite", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@denuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idioma", SqlDbType.Int).Value = idioma;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getTemaModal(Int64 idTema)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_getTemaModal", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idTema", SqlDbType.Int).Value = idTema;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string saveTema(int idDenuncia, int idTema, string tema, string asunto, string actividades, string detalleActividades, string planAccion, string conclusiones, int resultado, int beneficio, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarTema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@idTema", SqlDbType.Int).Value = idTema;
                        cmd.Parameters.Add("@tema", SqlDbType.VarChar).Value = tema;
                        //cmd.Parameters.Add("@subTema", SqlDbType.VarChar).Value = subtema;
                        cmd.Parameters.Add("@asunto", SqlDbType.VarChar).Value = asunto;
                        cmd.Parameters.Add("@actividades", SqlDbType.Text).Value = actividades;
                        cmd.Parameters.Add("@detalleActividades", SqlDbType.Text).Value = detalleActividades;
                        cmd.Parameters.Add("@planAccion", SqlDbType.VarChar).Value = planAccion;
                        cmd.Parameters.Add("@conclusiones", SqlDbType.VarChar).Value = conclusiones;
                        cmd.Parameters.Add("@resultado", SqlDbType.Int).Value = resultado;
                        cmd.Parameters.Add("@beneficio", SqlDbType.Int).Value = beneficio;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string deleteTema(int idTema, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteTema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idTema", SqlDbType.Int).Value = idTema;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string saveComentario(int idDenuncia, string comentario, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarComentario", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = comentario;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string saveConclusion(int idDenuncia, string conclusion, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarConclusion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@conclusion", SqlDbType.Text).Value = conclusion;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string saveDenunciado(int id, int idDenuncia, int tipo, string usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarDenunciado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.VarChar).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string delDenunciado(int id, int idDenuncia, int tipo, string usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteDenunciado", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.VarChar).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendAuditoria(int idDenuncia, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarAuditoria", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendVoBo(int idDenuncia, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarVoBo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendRevision(int idDenuncia, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarRevision", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendRechazar(int idDenuncia, string comentarioRechazo, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarRechazo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = comentarioRechazo;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendMadurez(int idDenuncia, int madurez, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarMadurez", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@madurez", SqlDbType.Int).Value = madurez;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendRechazarInv(int idDenuncia, string comentarioRechazo, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarRechazoInv", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@comentario", SqlDbType.VarChar).Value = comentarioRechazo;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string sendGerente(int idDenuncia, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_EnviarGerente", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public string saveArchivo(int tipo, int id, string nombreOriginal, string nombre, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarArchivo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@nombreOriginal", SqlDbType.VarChar).Value = nombreOriginal;
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombre;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public DataTable getSoportes(int tipo, int id)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_getSoportes", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getSoportesCerradas(int id)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_getSoportesCerradas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string deleteSoporte(int idSoporte, int usuarioBaja)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_DeleteSoporte", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@idSoporte", SqlDbType.Int).Value = idSoporte;
                        cmd.Parameters.Add("@usuarioBaja", SqlDbType.Int).Value = usuarioBaja;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public int validarTema(int idTema)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_validarTema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idTema", SqlDbType.Int).Value = idTema;
                        con.Open();
                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string updateVisto(int idDenuncia, int usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_updateVisto", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idDenuncia", SqlDbType.Int).Value = idDenuncia;
                        cmd.Parameters.Add("@usuario", SqlDbType.Int).Value = usuario;
                        con.Open();

                        cmd.ExecuteNonQuery();
                        return "exito";
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string GetIPAddress()
        {
            IPHostEntry Host = default(IPHostEntry);
            string Hostname = null;
            string IPAddress = "";
            Hostname = System.Environment.MachineName;
            Host = Dns.GetHostEntry(Hostname);
            foreach (IPAddress IP in Host.AddressList)
            {
                if (IP.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    IPAddress = Convert.ToString(IP);
                }
            }

            return IPAddress;
        }

        public int saveUsuario(int idUsuario, string usuario, string nombre, string correo, string grupo, string empresa, string sitio, string departamento, Int16 investigador, Int16 delegado, Int16 revisor , Int16 enterado, Int16 activo, int usuarioAlta, Int16 adminDen)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarUsuario", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombre;
                        cmd.Parameters.Add("@correo", SqlDbType.VarChar).Value = correo;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@sitio", SqlDbType.VarChar).Value = sitio;
                        cmd.Parameters.Add("@departamento", SqlDbType.VarChar).Value = departamento;
                        cmd.Parameters.Add("@investigador", SqlDbType.Bit).Value = investigador;
                        cmd.Parameters.Add("@delegado", SqlDbType.Bit).Value = delegado;
                        cmd.Parameters.Add("@revisor", SqlDbType.Bit).Value = revisor;
                        cmd.Parameters.Add("@enterado", SqlDbType.Bit).Value = enterado;
                        cmd.Parameters.Add("@adminDen", SqlDbType.Bit).Value = adminDen;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                return 0;
                throw;
            }
        }

        public int saveAdminDen(string empresas, int idUsuario, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarAdminDen", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@empresas", SqlDbType.VarChar).Value = empresas;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                return 0;
                throw;
            }
        }

        public int saveSitiosAdminDen(string empresas, int idUsuario, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarSitiosAdminDen", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@sitios", SqlDbType.VarChar).Value = empresas;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                return 0;
                throw;
            }
        }

        public int saveAreasAdminDen(string areas, int idUsuario, int usuarioAlta)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_PR_GuardarAreasAdminDen", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@areas", SqlDbType.VarChar).Value = areas;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.Int).Value = usuarioAlta;

                        con.Open();
                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                return 0;
                throw;
            }
        }

        public DataTable getResponsable(string grupo, string empresa, string sitio, int tipo)
        {
            string filtro = "";

            if (tipo == 1) {
                filtro = " where EsInvestigador = 1 ";
            } else {
                filtro = " where EsRevisor = 1 ";
            }


            if (grupo != "") {

                filtro = filtro + " and grupo = '" + grupo + "' ";
            }

            if (empresa != "")
            {

                filtro = filtro + " and empresa = '" + empresa + "' ";
            }

            if (sitio != "")
            {

                filtro = filtro + " and sitio = '" + sitio + "' ";
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT [idusuario],[Nombre] FROM [dbo].[PR_CatalogoUsuarioPortal] "+ " " + filtro ;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("responsable");
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

         public int reasignarDenuncias(int responsableOriginal,int responsableAReasginar, string denuncias)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_pr_reasignar_denuncias", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // cmd.Parameters.Add("@idIssue", SqlDbType.Int).Value = null;
                        cmd.Parameters.Add("@responsableOriginal", SqlDbType.Int).Value = responsableOriginal;
                        cmd.Parameters.Add("@responsableAReasignar", SqlDbType.Int).Value = responsableAReasginar;
                        cmd.Parameters.Add("@denuncias", SqlDbType.VarChar).Value = denuncias;

                        con.Open();
                        //cmd.ExecuteNonQuery();

                        int id = int.Parse(cmd.ExecuteScalar().ToString());
                        return id;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string saveImportancia(string importancia, string descripcion,int RecordatorioAtencion, int RecordatorioAteEscala, int RecordatorioResponsable, int RecordatorioEscalar, string EscalacionUsuario, int idBQ, bool activo, string usuarioCreacion)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GuardarImportancia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        
                        
                        cmd.Parameters.Add("@importancia", SqlDbType.VarChar).Value = importancia;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@RecordatorioAtencion", SqlDbType.Int).Value = RecordatorioAtencion;
                        cmd.Parameters.Add("@RecordatorioAteEscala", SqlDbType.Int).Value = RecordatorioAteEscala;
                        cmd.Parameters.Add("@RecordatorioResponsable", SqlDbType.Int).Value = RecordatorioResponsable;
                        cmd.Parameters.Add("@RecordatorioEscalar", SqlDbType.Int).Value = RecordatorioEscalar;
                        cmd.Parameters.Add("@EscalacionUsuario", SqlDbType.VarChar).Value = EscalacionUsuario;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@UsuarioCreacion", SqlDbType.VarChar).Value = usuarioCreacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public DataTable getImportancia(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GetImportancia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string updateImportancia(int idImportancia,string importancia, string descripcion, int RecordatorioAtencion, int RecordatorioAteEscala, int RecordatorioResponsable, int RecordatorioEscalar, string EscalacionUsuario, int idBQ, bool activo, string usuarioModificacion)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_Importancia", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@idImportancia", SqlDbType.Int).Value = idImportancia;
                        cmd.Parameters.Add("@importancia", SqlDbType.VarChar).Value = importancia;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@RecordatorioAtencion", SqlDbType.Int).Value = RecordatorioAtencion;
                        cmd.Parameters.Add("@RecordatorioAteEscala", SqlDbType.Int).Value = RecordatorioAteEscala;
                        cmd.Parameters.Add("@RecordatorioResponsable", SqlDbType.Int).Value = RecordatorioResponsable;
                        cmd.Parameters.Add("@RecordatorioEscalar", SqlDbType.Int).Value = RecordatorioEscalar;
                        cmd.Parameters.Add("@EscalacionUsuario", SqlDbType.VarChar).Value = EscalacionUsuario;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@UsuarioModificacion", SqlDbType.VarChar).Value = usuarioModificacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable getClasificacionesBQ(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GetClasificaciones", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string saveClasificacion(string clasificacion, string descripcion, string tipoClas, bool queja, bool enviaCorreo, bool activo, int idBQ, string usuarioCreacion)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GuardarClasificacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@clasificacion", SqlDbType.VarChar).Value = clasificacion;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@tipoClas", SqlDbType.VarChar).Value = tipoClas;
                        cmd.Parameters.Add("@queja", SqlDbType.Bit).Value = queja;
                        cmd.Parameters.Add("@enviaCorreo", SqlDbType.Bit).Value = enviaCorreo;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;                        
                        cmd.Parameters.Add("@usuarioCreacion", SqlDbType.VarChar).Value = usuarioCreacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public string saveConducto(string conducto, string descripcion, bool activo, string usuarioCreacion, int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GuardarConducto", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@conducto", SqlDbType.VarChar).Value = conducto;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;
                        cmd.Parameters.Add("@usuarioCreacion", SqlDbType.VarChar).Value = usuarioCreacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable getConductosBQ(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GetConductos", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getFormasBQ(int idConducto, int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GetFormas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idConducto", SqlDbType.Int).Value = idConducto;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string updateForma(int idForma, int idConducto, int idBuzon, string forma, string descripcion, bool activo, string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_Forma", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@idForma", SqlDbType.Int).Value = idForma;
                        cmd.Parameters.Add("@idConducto", SqlDbType.Int).Value = idConducto;
                        cmd.Parameters.Add("@idBuzon", SqlDbType.Int).Value = idBuzon;
                        cmd.Parameters.Add("@forma", SqlDbType.VarChar).Value = forma;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@usuarioModificacion", SqlDbType.VarChar).Value = usuario;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public string updateConducto(int id, string conducto, string descripcion, bool activo, string usuarioModificacion, int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_Conducto", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@conducto", SqlDbType.VarChar).Value = conducto;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@UsuarioModificacion", SqlDbType.VarChar).Value = usuarioModificacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable getUsuariosEscalacion(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_UsuariosEscalacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());

                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string updateClasificacion(int id, string clasificacion, string descripcion, bool queja, bool enviaCorreo, bool activo, string usuarioModificacion, int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_Clasificacion", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        cmd.Parameters.Add("@clasificacion", SqlDbType.VarChar).Value = clasificacion;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@queja", SqlDbType.Bit).Value = queja;
                        cmd.Parameters.Add("@enviaCorreo", SqlDbType.Bit).Value = enviaCorreo;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.VarChar).Value = idBQ;                        
                        cmd.Parameters.Add("@usuarioModificacion", SqlDbType.VarChar).Value = usuarioModificacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "exito";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }

        public DataTable getTemas(string sParam, int iIdBQ, int iId) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Tema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sParam;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string postTemas(string sOpt, int iId, string sDesc, bool bAct, string sUsr, int iIdBQ)  //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Tema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = sDesc;
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = bAct;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = sUsr;
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        con.Open();

                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        return "Ok";
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getSubtemas(string sParam, int iId) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Subtema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sParam;
                        cmd.Parameters.Add("@P_IdTema", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = "";

                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string postSubtemas(string sOpt, int iIdTema, int iId, string sDesc, bool bAct, string sUsr)  //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Subtema", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_IdTema", SqlDbType.Int).Value = iIdTema;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = sDesc;
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = bAct;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = sUsr;

                        con.Open();

                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        return "Ok";
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string postTipo(string sOpt, int iId, string sDesc, bool bAct, string sUsr, int iIdBQ)  //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Tipo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = sDesc;
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = bAct;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = sUsr;
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        con.Open();

                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        return "Ok";
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getTipo(string sParam, int iIdBQ, int iId) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_Cat_Tipo", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sParam;
                        cmd.Parameters.Add("@P_Id", SqlDbType.Int).Value = iId;
                        cmd.Parameters.Add("@P_Descripcion", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }


        public string postBQ(string sOpt, int iIdBQ, Boolean bCierre, Boolean bComite, byte[] bPhoto, Boolean bActivo, string sUsr)  //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_PortalQuejas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        cmd.Parameters.Add("@P_ProcesoCierre", SqlDbType.Bit).Value = bCierre;
                        cmd.Parameters.Add("@P_ProcesoComite", SqlDbType.Bit).Value = bComite;
                        if (bPhoto != null)
                        {
                            cmd.Parameters.Add("@P_Logo", SqlDbType.VarBinary).Value = bPhoto;
                        }
                        else
                        {
                            cmd.Parameters.Add("@P_Logo", SqlDbType.VarBinary).Value = System.Data.SqlTypes.SqlBinary.Null;
                        }
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = bActivo;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = sUsr;
                        con.Open();

                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        return "Ok";
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getBQ(string sOpt, int iIdBQ) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_PortalQuejas", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        cmd.Parameters.Add("@P_ProcesoCierre", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_ProcesoComite", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_Logo", SqlDbType.VarBinary).Value = System.Data.SqlTypes.SqlBinary.Null;
                        cmd.Parameters.Add("@P_Activo", SqlDbType.Bit).Value = false;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = "";
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable getBQUser(string sOpt, string sCat, int iIdBQ) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_User", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_Cat", SqlDbType.VarChar).Value = sCat;
                        cmd.Parameters.Add("@P_Id_Usr", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = iIdBQ;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string postBQUser(string sOpt, string sCat, int iCatUsr, string sUsr)  //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_User", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_Cat", SqlDbType.VarChar).Value = sCat;
                        cmd.Parameters.Add("@P_Id_Usr", SqlDbType.Int).Value = iCatUsr;
                        cmd.Parameters.Add("@P_Usr", SqlDbType.VarChar).Value = sUsr;
                        cmd.Parameters.Add("@P_IdBQ", SqlDbType.Int).Value = 0;
                        con.Open();

                        cmd.ExecuteNonQuery();
                        con.Close();
                        con.Dispose();
                        return "Ok";
                    }
                }
            }
            catch
            {
                throw;
            }
        }


        public DataTable getBQId(string sOpt, string sCat) //Saul Sanchez
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_BQ_SelId", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@P_Option", SqlDbType.VarChar).Value = sOpt;
                        cmd.Parameters.Add("@P_Str1", SqlDbType.VarChar).Value = sCat;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public string saveForma(int idConducto, string forma, string descripcion, bool activo, string usuarioCreacion, int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GuardarForma", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@idConducto", SqlDbType.Int).Value = idConducto;
                        cmd.Parameters.Add("@forma", SqlDbType.VarChar).Value = forma;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;                        
                        cmd.Parameters.Add("@usuarioCreacion", SqlDbType.VarChar).Value = usuarioCreacion;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable getBuzonesByGrupoEmpresa(string empresa, string grupo) //Rodolfo Godina
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Get_BuzonesPorGrupoEmpresa", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string saveUsuariosBuzones(int idUsuario, int idBQ, string usuarioAlta, bool esVobo, bool esInvestigador, bool esDelegado, bool esRevisor, bool esEnterado, bool adminQuejas, bool activo) //Rodolfo Godina
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_SaveUsuariosBuzones", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBQ;
                        cmd.Parameters.Add("@usuarioAlta", SqlDbType.VarChar).Value = usuarioAlta;
                        cmd.Parameters.Add("@BQEsVobo", SqlDbType.Bit).Value = esVobo;
                        cmd.Parameters.Add("@BQEsInvestigador", SqlDbType.Bit).Value = esInvestigador;
                        cmd.Parameters.Add("@BQEsDelegado", SqlDbType.Bit).Value = esDelegado;
                        cmd.Parameters.Add("@BQEsRevisor", SqlDbType.Bit).Value = esRevisor;
                        cmd.Parameters.Add("@BQEsEnterado", SqlDbType.Bit).Value = esEnterado;
                        cmd.Parameters.Add("@BQAdminQuejas", SqlDbType.Bit).Value = adminQuejas;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;


                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable checarRegistroUsuariosBuzones(int idUsuario, int idBuzon)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_ChecarRegistroBuzonesUsuarios", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@FK_idBQ", SqlDbType.Int).Value = idBuzon;
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getUsuariosBuzon(int idUsuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Get_UsuariosBuzon", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;                        
                        con.Open();

                        DataTable dt = new DataTable();

                        dt.Load(cmd.ExecuteReader());
                        con.Close();
                        con.Dispose();
                        return dt;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
        public string updateUsuarioBuzon(int idUsuario, int idBQ, bool esVobo, bool esInvestigador, bool esDelegado, bool esRevisor, bool esEnterado, bool adminQuejas, bool activo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_UsuariosBuzon", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;
                        cmd.Parameters.Add("@idBuzon", SqlDbType.Int).Value = idBQ;                    
                        cmd.Parameters.Add("@esVobo", SqlDbType.Bit).Value = esVobo;
                        cmd.Parameters.Add("@esInvestigador", SqlDbType.Bit).Value = esInvestigador;
                        cmd.Parameters.Add("@esDelegado", SqlDbType.Bit).Value = esDelegado;
                        cmd.Parameters.Add("@esRevisor", SqlDbType.Bit).Value = esRevisor;
                        cmd.Parameters.Add("@esEnterado", SqlDbType.Bit).Value = esEnterado;
                        cmd.Parameters.Add("@adminQuejas", SqlDbType.Bit).Value = adminQuejas;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;


                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public string saveBuzon(string grupo, string empresa, string nombreBuzon, string descripcion, bool activo, string usuarioCreacion)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_GuardarBuzon", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@grupo", SqlDbType.VarChar).Value = grupo;
                        cmd.Parameters.Add("@empresa", SqlDbType.VarChar).Value = empresa;
                        cmd.Parameters.Add("@nombreBuzon", SqlDbType.VarChar).Value = nombreBuzon;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@usuarioCreacion", SqlDbType.VarChar).Value = usuarioCreacion;

                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar guardar";
                throw;
            }
        }
        public DataTable getBuzones()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT idBQ, grupo, empresa, nombreBQ, descripcion, activo FROM BQ_Cat_Buzones";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public string updateBuzon(int idBQ, string nombreBuzon, string descripcion, bool activo, string usuario)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_BQ_Update_Buzon", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.Add("@idBQ", SqlDbType.Int).Value = idBQ;
                        cmd.Parameters.Add("@nombreBuzon", SqlDbType.VarChar).Value = nombreBuzon;
                        cmd.Parameters.Add("@descripcion", SqlDbType.VarChar).Value = descripcion;
                        cmd.Parameters.Add("@activo", SqlDbType.Bit).Value = activo;
                        cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario;


                        con.Open();
                        cmd.ExecuteNonQuery();

                        return "OK";
                    }
                }
            }
            catch
            {
                return "Ocurrio un error al intentar actualizar";
                throw;
            }
        }
        public DataTable getClasificacionesByFKIdBQ(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    List<string> usuarios = new List<string>();
                    String query = "SELECT id, clasificacion, descripcion FROM BQ_Cat_Clasificaciones WHERE activo = 1 and FK_idBQ = " + idBQ;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getImportanciasByFKIdBQ(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    
                    String query = "SELECT idImportancia, FK_idBQ, importancia FROM BQ_Cat_Importancia WHERE activo = 1 and FK_idBQ = " + idBQ;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getConductoByFKIdBq(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT id, FK_idBQ, conducto FROM BQ_Cat_Conducto WHERE activo = 1 and FK_idBQ = " + idBQ;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getFormasByFKIdBq(int idBQ, int idConducto)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT id, forma, idConducto FROM BQ_Cat_Forma WHERE activo = 1 and FK_idBQ = " + idBQ + " and idConducto = " + idConducto + ";";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getTemasByIdBQ(int idBQ)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT Id, IdTema, Descripcion FROM BQ_Cat_Tema WHERE Activo = 1 and IdBQ = " + idBQ;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getSubtemaByIdBQ(int idBQ, int idTema)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT Id, IdSubtema, Descripcion FROM BQ_Cat_Subtema WHERE Activo = 1 and IdBQ = " + idBQ + " and IdTema = " + idTema;
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getTiposBuzon()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT * FROM Tipos;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }
        public DataTable getResponsablesMensaje(string grupo)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {

                    String query = "SELECT Id, Nombre, CorreoResponsable,EnteradosEmails FROM ComboResponsables WHERE Grupo = " + "'"+grupo+"'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

    }
}