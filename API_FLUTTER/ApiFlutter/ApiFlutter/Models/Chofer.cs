﻿using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace ApiFlutter.Models
{
    public class Chofer
    {
        [Key]
        public int Cedula { get; set; }
        [Required]
        public string Nombre { get; set; } = "";
        [Required]
        public string Apellidos { get; set; } = "";
        [Required]
        public int Telefono { get; set; } = 0;
        [Required]
        public string Direccion { get; set; } = "";
        [Required]
        public string Contrasena { get; set; } = "";
    }
}
