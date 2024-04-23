using Microsoft.EntityFrameworkCore;

namespace ApiFlutter.Models
{
    public class ApiDB : DbContext
    {
        public ApiDB(DbContextOptions option) : base (option)
        {

        }

        public DbSet<Usuario> usuario { get; set; }
        public DbSet<Chofer> chofer { get; set; }
        public DbSet<Horario> horario { get; set; }
        public DbSet<Asiento> asiento { get; set; }
        public DbSet<Tiquete> tiquete { get; set; }
        public DbSet<Vehiculo> vehiculo { get; set; }
        public DbSet<Location> location { get; set; }




    }
}
