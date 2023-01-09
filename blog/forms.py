from django import forms
from .models import Comment , Rating
class CommentForm (forms.ModelForm):
    def __init__(self, *args, **kwargs):
        self.author = kwargs.pop('author', None)
        self.detaillocation = kwargs.pop('detaillocation', None)
        super().__init__(*args, **kwargs)
    class Meta:
        model = Comment
        fields = ['body']

class RatingForm (forms.ModelForm):
    def __init__(self, *args, **kwargs):
        self.author = kwargs.pop('author', None)
        self.detaillocation = kwargs.pop('detaillocation', None)
        super().__init__(*args, **kwargs)
    class Meta:
        model = Rating
        fields = ['rating']