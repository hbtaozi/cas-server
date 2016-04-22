<%@ page import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="com.cas.authentication.CasConstants" %>
<%@page contentType="image/jpeg" %>
<%!
    Color getRandColor(int fc, int bc)
    {
        Random random = new Random();
        if (fc > 255) fc = 255;
        if (bc > 255) bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }
%>
<%
    try
    {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        int codeLen = 4;
        int width = 15*codeLen, height = 30;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        OutputStream os = response.getOutputStream();
        Graphics g = image.getGraphics();
        Random random = new Random();
        g.setColor(getRandColor(50, 250));
        g.fillRect(0, 0, width, height);

        g.setFont(new Font("Times New Roman", Font.PLAIN, 20));
        Color lineColor =   getRandColor(150, 255);
        g.setColor(lineColor);
        for (int i = 0; i < 155; i++)
        {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }
        String sRand = "";
        for (int i = 0; i < codeLen; i++)
        {
            String codeTable ="qwe2rty3ui4pasdfgh5jkzxcvb6nmQWE7RTYUPAS8DFGHJKL9ZXCVBNM";
            String
                    rand = String.valueOf(codeTable.charAt(random.nextInt(codeTable.length())));
            sRand += rand;
            g.setColor(new Color(1+random.nextInt(140), 1 + random.nextInt(140), 1 + random.nextInt(140)));            
            g.drawString(rand, 13 * i + 3, 20);
        }
        session.setAttribute(CasConstants.AUTH_CODE_SESSION_KEY, sRand);
        g.dispose();

        ImageIO.write(image, "JPEG", os);
        os.flush();
        os.close();
        os = null;
        response.flushBuffer();
        out.clear();
        out = pageContext.pushBody();
    }
    catch
            (IllegalStateException e)
    {
        System.out.println(e.getMessage());
        e.printStackTrace();
    }%>
