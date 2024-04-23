using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    [Keyless]
    public class Location
    {
        [Required]
        public double latitud { get; set; }
        [Required]
        public double longitud { get; set; }


    }
}
