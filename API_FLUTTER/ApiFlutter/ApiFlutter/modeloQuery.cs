using ApiFlutter.Models;
using Microsoft.EntityFrameworkCore;

namespace ApiFlutter
{
    public class modeloQuery : ModeloDatos
    {
        ApiDB _dbContext;

        public modeloQuery(ApiDB dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<bool> addUser(Usuario usuario)
        {

            FormattableString query = $"exec SP_RegistrarPersona {usuario.Cedula},{usuario.Nombre},{usuario.Apellidos},{usuario.Telefono},{usuario.Direccion},{usuario.Contrasena},{usuario.Saldo},{usuario.Discapacitado}";
            int afectado = await _dbContext.Database.ExecuteSqlAsync(query);
            return afectado > 0;

        }

        public async Task<bool> updateSaldo(int cedula, double ammount)
        {

            FormattableString query = $"exec SP_updateSaldo {cedula},{ammount}";
            int afectado = await _dbContext.Database.ExecuteSqlAsync(query);
            return afectado > 0;

        }

        public Task<bool> delUser(string usuario)
        {
            throw new NotImplementedException();
        }

        public  async Task<List<Usuario>> GetAll()
        {
            FormattableString query = $"SELECT Cedula,nombre,apellidos,telefono,direccion,Convert(NVARCHAR(MAX),contrasena) as contrasena,saldo,discapacitado from dbo.Cliente\r\n";
            return await _dbContext.Database.SqlQuery<Usuario>(query).ToListAsync();

        }

        public async Task<Usuario> getUser(int cedula, string contrasena)
        {
            FormattableString query = $"exec SP_getInfoInicio {cedula},{contrasena}";
            return _dbContext.Database.SqlQuery<Usuario>(query).AsEnumerable().FirstOrDefault();
        }

        public Task<bool> updateUser(string usuario)
        {
            throw new NotImplementedException();
        }

        async Task<int> ModeloDatos.checkExists(int cedula)
        {
            FormattableString query = $"exec SP_checkExiste {cedula}";
            return _dbContext.Database.SqlQuery<int>(query).AsEnumerable().First();

        }

        async Task<bool> ModeloDatos.addChofer(Chofer chofer)
        {
            FormattableString query = $"exec SP_RegistrarChofer {chofer.Cedula},{chofer.Nombre},{chofer.Apellidos},{chofer.Telefono},{chofer.Direccion},{chofer.Contrasena}";
            int afectado = await _dbContext.Database.ExecuteSqlAsync(query);
            return afectado > 0;
        }

        Task<bool> ModeloDatos.updateChofer(string chofer)
        {
            throw new NotImplementedException();
        }

        Task<bool> ModeloDatos.delChofer(string chofer)
        {
            throw new NotImplementedException();
        }

        async Task<Chofer> ModeloDatos.getChofer(int cedula, string contrasena)
        {
            FormattableString query = $"exec SP_getInfoChofer {cedula},{contrasena}";
            return _dbContext.Database.SqlQuery<Chofer>(query).AsEnumerable().FirstOrDefault();
        }

        async Task<List<Horario>> ModeloDatos.getHorario()
        {
            FormattableString query = $"exec SP_ConsultaHorario";
            return await _dbContext.Database.SqlQuery<Horario>(query).ToListAsync();
        }

        async Task<List<Asiento>> ModeloDatos.getAsiento(int parada, int horario)
        {
            FormattableString query = $"exec SP_ConsultaAsientos {parada},{horario}";
            return await _dbContext.Database.SqlQuery<Asiento>(query).ToListAsync();
        }

        async Task<List<Tiquete>> ModeloDatos.getTiquete(int cedula)
        {
            FormattableString query = $"exec SP_ConsultaTiquete {cedula}";
            return await _dbContext.Database.SqlQuery<Tiquete>(query).ToListAsync();
        }

        async Task<bool> ModeloDatos.compraTiquete(int cedula, int asiento, int parada, int horario)
        {
            FormattableString query = $"exec SP_RealizarCompra {cedula},{asiento},{parada},{horario}";
            int afectado = await _dbContext.Database.ExecuteSqlAsync(query);
            return afectado > 0;
        }

         async Task<List<Vehiculo>> ModeloDatos.getVehiculos(int cedula)
        {
            FormattableString query = $"exec SP_getBusesChofer {cedula}";
            return await _dbContext.Database.SqlQuery<Vehiculo>(query).ToListAsync();
        }
    }
}
