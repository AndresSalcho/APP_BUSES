using ApiFlutter.Models;

namespace ApiFlutter
{
    public interface ModeloDatos
    {
        Task<List<Usuario>> GetAll();

        Task<bool> addUser(Usuario usuario);
        Task<bool> updateUser(string usuario);
        Task<bool> delUser(string usuario);

        Task<Usuario> getUser(int cedula, string contrasena);
        Task<int> checkExists(int cedula);
        Task<bool> updateSaldo(int cedula, double ammount);

        Task<bool> addChofer(Chofer chofer);
        Task<bool> updateChofer(string chofer);
        Task<bool> delChofer(string chofer);
        Task<Chofer> getChofer(int cedula, string contrasena);

        Task<List<Horario>> getHorario();
        Task<List<Asiento>> getAsiento(int parada, int horario);
        Task<List<Tiquete>> getTiquete(int cedula);
        Task<List<Vehiculo>> getVehiculos(int cedula);


        Task<bool> compraTiquete(int cedula, int asiento, int parada, int horario);







    }
}
