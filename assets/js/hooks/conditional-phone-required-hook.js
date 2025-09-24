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

        this.phoneLabel = this.phoneInput.closest('label')?.querySelector('span.label');
        this.originalLabelText = this.phoneLabel?.textContent;

        this.updatePhoneRequirement = this.updatePhoneRequirement.bind(this);

        if (this.phoneRadio) {
            this.phoneRadio.addEventListener('change', this.updatePhoneRequirement);
        }

        this.updatePhoneRequirement();
    },

    updatePhoneRequirement() {
        const isPhoneSelected = this.phoneRadio && this.phoneRadio.checked;

        if (isPhoneSelected) {
            this.makePhoneRequired();
        } else {
            this.makePhoneOptional();
        }
    },

    makePhoneRequired() {
        this.phoneInput.setAttribute('required', 'required');
        this.updateLabel('(obligatoire)');
    },

    makePhoneOptional() {
        this.phoneInput.removeAttribute('required');
        this.updateLabel('(optionnel)');
    },

    updateLabel(status) {
        if (this.phoneLabel) {
            const baseLabelText = this.originalLabelText.replace(/\s*\((?:obligatoire|optionnel)\)/, '');
            const newLabelText = `${baseLabelText} ${status}`;
            this.phoneLabel.textContent = newLabelText;
        }
    },

    destroyed() {
        if (this.phoneRadio) {
            this.phoneRadio.removeEventListener('change', this.updatePhoneRequirement);
        }
    }
};

export default ConditionalPhoneRequiredHook;