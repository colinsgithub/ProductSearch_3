/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import bean.Merchandise;
import bean.Store;
import bean.StoreMerchandise;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.List;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
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
            EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            Store store = em.find(Store.class, Integer.parseInt(storeId));
            em.getTransaction().commit();
            em.close();
            factory.close();
            
            
            
            
            //List<StoreMerchandise> list = new ArrayList<StoreMerchandise>(merchandises);
            Gson gson = new Gson();
            //Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
            //String json = gson.toJson(store);
            response.getWriter().print(store.getUserID().getEmail());
        }
    }
}
