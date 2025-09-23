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
        this.phoneRadio = form.querySelector('input[name="preferred_contact_method"][value="phone"]');

        this.originalPlaceholder = this.phoneInput.getAttribute('placeholder') || '';

        this.updatePhoneRequirement = this.updatePhoneRequirement.bind(this);

        if (this.phoneRadio) {
            this.phoneRadio.addEventListener('change', this.updatePhoneRequirement);
        }

        this.updatePhoneRequirement();
    },

    updatePhoneRequirement() {
        const isPhoneSelected = this.isPhoneRadioChecked();

        if (isPhoneSelected) {
            this.makePhoneRequired();
        } else {
            this.makePhoneOptional();
        }
    },

    isPhoneRadioChecked() {
        return this.phoneRadio && this.phoneRadio.checked;
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
        if (this.phoneRadio) {
            this.phoneRadio.removeEventListener('change', this.updatePhoneRequirement);
        }
    }
};

export default ConditionalPhoneRequiredHook;