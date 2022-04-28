using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Noomina.Controllers
{
    public class ProcedimientoController : Controller
    {
        // GET: Procedimiento
        public ActionResult Index()
        {
            return View();
        }

        // GET: Procedimiento/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Procedimiento/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Procedimiento/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Procedimiento/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Procedimiento/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Procedimiento/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Procedimiento/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
