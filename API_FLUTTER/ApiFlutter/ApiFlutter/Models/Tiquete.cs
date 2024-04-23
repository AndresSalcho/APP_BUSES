using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    public class Tiquete
    {
        [Key]
        public int idPago { get; set; }
        [Required]
        public int CedulaCliente { get; set; }
        [Required]
        public string descripcipon { get; set; }
        [Required]
        public DateTime Fecha { get; set; }
        [Required]
        public string NumeroSerieBus { get; set; }
        [Required]
        public double Costo { get; set; }
        [Required]
        public string LugarLlegada { get; set; }
        [Required]
        public string LugarSalida { get; set; }
    }
}
