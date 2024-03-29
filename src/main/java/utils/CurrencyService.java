package utils;

import java.util.Currency;

public class CurrencyService {
    public static String formatPrice(int price)
    {
        String Price = "" + price;
        String formatedPrice = "";
        int count = 0;
        for (int i = Price.length() - 1; i >= 0; i--) {
            count++;
            formatedPrice = Price.charAt(i) + formatedPrice;
            if (count % 3 == 0 && i != 0)
            {
                formatedPrice = "." + formatedPrice;
            }
        }
        return formatedPrice;
    }
}
