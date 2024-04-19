using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    public class Asiento
    {
        [Key]
        public int idHorario { get; set; }
        [Required]
        public TimeSpan Hora { get; set; }
        [Required]
        public string DireccionParada { get; set; } = "";
        [Required]
        public double CostoParada { get; set; } = 0.0;
        [Required]
        public string BusSerie { get; set; } = "";
        [Required]
        public string estado { get; set; } = "";
        [Required]
        public int idAsiento { get; set; }
        [Required]
        public Boolean Ocupado { get; set; }
        [Required]
        public Boolean Exclusive { get; set; }
        [Required]
        public int ClientePresente { get; set; }
    }
}
