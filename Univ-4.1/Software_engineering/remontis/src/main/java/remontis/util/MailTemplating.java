package remontis.util;

public final class MailTemplating {

    public enum TemplateType{
        NEW_ORDER("You have new order: "),
        DONE_ORDER("Your order is ready: "),
        COMMENT("Your order was updated: ");

        private String template;

        public String getTemplate() {
            return template;
        }

        TemplateType(String template) {
            this.template = template;
        }
    }

    public static String getTemplate(TemplateType templateType){
        return templateType.getTemplate();
    }

}
