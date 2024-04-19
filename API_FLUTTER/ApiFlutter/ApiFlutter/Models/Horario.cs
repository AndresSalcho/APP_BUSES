using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    public class Horario
    {
        [Key]
        public int idHorario { get; set; }
        [Required]
        public TimeSpan Hora { get; set; }
        [Required]
        public int idParada { get; set; } = 0;
        [Required]
        public string Parada { get; set; } = "";
        [Required]
        public double CostoParada { get; set; } = 0.0;
        [Required]
        public string BusSerie { get; set; } = "";
    }
}
