package TranslatorOO;

use v5.20;
use Type::Params qw( compile_named_oo );
use Types::Common::Numeric qw( PositiveInt );
use Types::Standard qw( ArrayRef Enum Optional Str );

sub submit_for_translation {
    my $self = shift;

    state $check = compile_named_oo(
        to_langs          => ArrayRef [Str],
        english_phrase_id => Optional [PositiveInt],
        phrase_group_ids  => Optional [ ArrayRef [PositiveInt] ],
        turnaround_time   => Optional [ Enum [ 1, 3, 5 ] ],
    );

    my $arg = $check->(@_);

    my $phrases_by_lang = $self->_filter_untranslated_phrases(
        $arg->english_prase_id,
        $arg->phrase_group_ids,
    ) or die 'No phrases to submit';

    ...;
}

1;
