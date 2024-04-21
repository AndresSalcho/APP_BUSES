using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    public class Vehiculo
    {
        [Key]
        public string BusSerie { get; set; }
        [Required]
        public string placa {  get; set; }
        [Required]
        public TimeSpan hora { get; set; }
        [Required]
        public string direccion { get; set; }
        [Required]
        public string LugarLlegada { get; set; }
        [Required]
        public string LugarSalida { get; set; }
    }
}
