using ApiFlutter.Models;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace ApiFlutter.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class QueryController : ControllerBase
    {
        ModeloDatos _modeloQuery;

        public QueryController(ModeloDatos modeloQuery)
        {
            _modeloQuery = modeloQuery;
        }

        // Get All usuarios
        [ProducesResponseType(typeof(List<Usuario>), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getAll()
        {
            try
            {
                return Ok(await _modeloQuery.GetAll());
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // GET Usuario
        [ProducesResponseType(typeof(Usuario), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getUser(int cedula, string contrasena)
        {
            try
            {
                var usuario = await _modeloQuery.getUser(cedula, contrasena);
                if (usuario == null)
                {
                    return NotFound();
                }
                return Ok(usuario);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(int), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> checkExists(int cedula)
        {
            try
            {
                var usuario = await _modeloQuery.checkExists(cedula);

                return Ok(usuario);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [HttpPost]
        public async Task<IActionResult> addUser([FromBody] Usuario user)
        {
            try
            {
                bool isGood = await _modeloQuery.addUser(user);
                if (isGood)
                {
                    return Ok("Persona Agregada con Exito");
                }
                return BadRequest("Operacion fallida");

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [HttpPost]
        public async Task<IActionResult> updateSaldo(int cedula, double ammount)
        {
            try
            {
                bool isGood = await _modeloQuery.updateSaldo(cedula, ammount);
                if (isGood)
                {
                    return Ok("Saldo actualizado con Exito");
                }
                return BadRequest("Operacion fallida");

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // GET Chofer
        [ProducesResponseType(typeof(Chofer), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getChofer(int cedula, string contrasena)
        {
            try
            {
                var chofer = await _modeloQuery.getChofer(cedula, contrasena);
                if (chofer == null)
                {
                    return NotFound();
                }
                return Ok(chofer);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [HttpPost]
        public async Task<IActionResult> addChofer([FromBody] Chofer chofer)
        {
            try
            {
                bool isGood = await _modeloQuery.addChofer(chofer);
                if (isGood)
                {
                    return Ok("Cofer Agregado con Exito");
                }
                return BadRequest("Operacion fallida");

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(List<Horario>), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getHorario()
        {
            try
            {
                var hora = await _modeloQuery.getHorario();
                if (hora == null)
                {
                    return NotFound();
                }
                return Ok(hora);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [ProducesResponseType(typeof(List<Asiento>), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getAsiento(int parada, int horario)
        {
            try
            {
                var asiento = await _modeloQuery.getAsiento(parada, horario);
                if (asiento == null)
                {
                    return NotFound();
                }
                return Ok(asiento);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [ProducesResponseType(typeof(List<Tiquete>), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getTiquete(int cedula)
        {
            try
            {
                var tiquete = await _modeloQuery.getTiquete(cedula);
                if (tiquete == null)
                {
                    return NotFound();
                }
                return Ok(tiquete);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(List<Vehiculo>), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getVehiculo(int cedula)
        {
            try
            {
                var vehiculo = await _modeloQuery.getVehiculos(cedula);
                if (vehiculo == null)
                {
                    return NotFound();
                }
                return Ok(vehiculo);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [HttpPost]
        public async Task<IActionResult> compraTiquete(int cedula, int asiento, int parada, int horario)
        {
            try
            {
                bool isGood = await _modeloQuery.compraTiquete(cedula,asiento,parada,horario);
                if (isGood)
                {
                    return Ok("Compra Exitosa");
                }
                return BadRequest("Operacion fallida");

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [HttpPost]
        public async Task<IActionResult> addLocation(string BusSerie, double lat, double lon)
        {
            try
            {
                bool isGood = await _modeloQuery.addLocation(BusSerie,lat,lon);
                if (isGood)
                {
                    return Ok("Coordenadas Agregadas con Exito");
                }
                return BadRequest("Operacion fallida");

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(Location), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getLocation(string BusSerie)
        {
            try
            {
                var location = await _modeloQuery.getLocation(BusSerie);
                if (location == null)
                {
                    return NotFound();
                }
                return Ok(location);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [ProducesResponseType(typeof(Location), (int)HttpStatusCode.OK)]
        [HttpGet]
        public async Task<IActionResult> getLocationParada(string BusSerie)
        {
            try
            {
                var location = await _modeloQuery.getLocationParada(BusSerie);
                if (location == null)
                {
                    return NotFound();
                }
                return Ok(location);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
