/**
 * Hook to conditionally make phone input required based on preferred contact method selection
 * Attached to the phone input field, it listens for changes in contact method radio buttons
 */
const ConditionalPhoneRequiredHook = {
    mounted() {
        this.initializePhoneValidation();
    },

    initializePhoneValidation() {
        this.phoneInput = this.el;
        const form = this.phoneInput.closest('form');
        this.contactMethodRadios = form.querySelectorAll('input[name="preferred_contact_method"]');

        this.originalPlaceholder = this.phoneInput.getAttribute('placeholder') || '';

        this.handleContactMethodChange = this.handleContactMethodChange.bind(this);

        this.contactMethodRadios.forEach(radio => {
            radio.addEventListener('change', this.handleContactMethodChange);
        });

        this.updatePhoneRequirement();
    },

    handleContactMethodChange(event) {
        this.updatePhoneRequirement();
    },

    updatePhoneRequirement() {
        const isPhoneSelected = this.isContactMethodSelected('phone');

        if (isPhoneSelected) {
            this.makePhoneRequired();
        } else {
            this.makePhoneOptional();
        }
    },

    isContactMethodSelected(method) {
        return Array.from(this.contactMethodRadios)
            .some(radio => radio.value === method && radio.checked);
    },

    makePhoneRequired() {
        this.phoneInput.setAttribute('required', 'required');
        this.updatePlaceholder('(obligatoire)');
    },

    makePhoneOptional() {
        this.phoneInput.removeAttribute('required');
        this.updatePlaceholder('(optionnel)');
    },

    updatePlaceholder(status) {
        const basePlaceholder = this.originalPlaceholder.replace(/\s*\((?:obligatoire|optionnel)\)/, '');
        const newPlaceholder = `${basePlaceholder} ${status}`;
        this.phoneInput.setAttribute('placeholder', newPlaceholder);
    },

    destroyed() {
        if (this.contactMethodRadios) {
            this.contactMethodRadios.forEach(radio => {
                radio.removeEventListener('change', this.handleContactMethodChange);
            });
        }
    }
};

export default ConditionalPhoneRequiredHook;