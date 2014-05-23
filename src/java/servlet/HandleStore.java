/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.Merchandise;
import bean.Store;
import bean.StoreMerchandise;
import bean.Tag;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author poonkaho
 */
@WebServlet(name = "HandleStore", urlPatterns = {"/HandleStore"})
public class HandleStore extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        String dbUrl = "jdbc:mysql://localhost:3306/product";
        String dbUser = "root";
        String dbPassword = "root";


    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();
        if ("list".equalsIgnoreCase(action)) {
            EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            Query q = em.createNamedQuery("Store.findAll", Store.class);
            List<Store> stores = q.getResultList();

            ArrayList storeList = new ArrayList(stores);
            request.setAttribute("stores", storeList);
            //Store result = em.find(Store.class, Integer.parseInt(storeId));
            em.getTransaction().commit();
            em.close();
            factory.close();

            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/index-2.jsp");
            rd.forward(request, response);
        } else if ("list2".equalsIgnoreCase(action)) {
            //String storeId = request.getParameter("storeId");

            EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            Query q = em.createNamedQuery("Store.findAll", Store.class);
            List<Store> stores = q.getResultList();

            ArrayList x = new ArrayList(stores);
            request.setAttribute("stores", x);
            //Store result = em.find(Store.class, Integer.parseInt(storeId));
            em.getTransaction().commit();
            em.close();
            factory.close();
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        } else if ("getAStore".equalsIgnoreCase(action)) {
            String storeId = request.getParameter("storeId");
            try {
                EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
                EntityManager em = factory.createEntityManager();
                em.getTransaction().begin();
                Store store = em.find(Store.class, Integer.parseInt(storeId));
                ArrayList<StoreMerchandise> merchandises = new ArrayList<StoreMerchandise>(store.getStoreMerchandiseCollection());

                JSONObject jsonObject = new JSONObject();

                JSONArray array = new JSONArray();
                for (int x = 0; x < merchandises.size(); x++) {
                    JSONArray merchandise = new JSONArray();
                    merchandise.put(merchandises.get(x).getMerchandise().getMerchandiseName());
                    merchandise.put(merchandises.get(x).getMerchandise().getMerchandiseDesc());
                    merchandise.put(merchandises.get(x).getMerchandise().getMerchandiseImage());
                    array.put(merchandise);
                }
                em.getTransaction().commit();
                em.close();
                factory.close();
                jsonObject.put("data", array);
                out.println(jsonObject);

            } catch (Exception e) {
                Logger.getLogger(HandleTag.class.getName()).log(Level.SEVERE, null);
            } finally {
                out.close();
            }
        }
    }
}
